#!/usr/bin/env wsapi.cgi

-- TODO:
-- * session expire

local gvt   = require 'luagravity'
local meta  = require 'luagravity.meta'

local lfs    = require 'lfs'
local digest = require('crypto').hmac.digest

local req = require 'wsapi.request'
local res = require 'wsapi.response'

math.randomseed(os.time())

local headers = { ['Content-type'] = 'text/html' }

local SESSIONS = {}

local s_match = string.match
local function acc (env, name)
    local pre, pos = s_match(name, '(.-)%.(.*)')
    if pre and pos then
        return acc(env[pre], pos)
    else
        return env, name
    end
end

return function (env)
    local req = req.new(env)

    local S
    local name, event = string.match(req.path_info, '/([^/]+)/?(.*)')
    local id = req.cookies[name]
    local host = assert(env.REMOTE_ADDR)

    -- TODO: (not ok) headers['Content-Location'] = '/rsp/'..app_name..'/'
    local res = res.new(200, headers)
    if id and SESSIONS[id] then
        S = SESSIONS[id]
        assert(S.name == name)
        assert(S.host == host)
    else
        id = digest("sha1", math.random(), os.time())
        local app = loadfile(name..'.lua')
        local dir
        if not app then
            dir = name
            app = assert(loadfile(name..'/init.lua'))
        end
        app = meta.apply(app)
        local app_env = getfenv(app)
        app = gvt.create(app, {name=name})
        S = { app=app, env=app_env, dir=dir, name=name, host=host }
        SESSIONS[id] = S
        res:set_cookie(name, id)
        if dir then lfs.chdir(dir) end
        gvt.start(app)
        if dir then lfs.chdir('..') end
    end

    -- DATA
    -- TODO: dangerous?
    local pub = S.env.pub or {}
    for var, v in pairs(req.GET) do
        local s1, s2 = acc(pub, var)
        assert(s1[s2], 'attempt to assign to undefined variable')
        if string.sub(v, 1, 1) == '!' then
            local v1, v2 = acc(pub, string.sub(v, 2))
            s1[s2] = v1[v2]
        else
            s1[s2] = v
        end
    end

    -- EVENT
    if event ~= '' then
        local dir = S.dir
        if dir then lfs.chdir(dir) end
        gvt.step(S.app, event)
        if dir then lfs.chdir('..') end
    end

    if S.app.state == 'ready' then
        res:delete_cookie(name)
        SESSIONS[id] = nil
    end

    res:write(S.env._html())
    return res:finish()
end
