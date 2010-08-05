#!/usr/bin/env wsapi.cgi

local gvt   = require 'luagravity'
local meta  = require 'luagravity.meta'

local lfs = require 'lfs'

local req = require 'wsapi.request'
local res = require 'wsapi.response'

local headers = { ['Content-type'] = 'text/html' }

local ID = 1
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
    local id = tonumber(req.cookies[name] or 0)

    -- TODO: (not ok) headers['Content-Location'] = '/rsp/'..app_name..'/'
    local res = res.new(200, headers)
    if SESSIONS[id] then
        S = SESSIONS[id]
        assert(gvt.is(S.app))
        assert(S.name == name)
        -- TODO: assert(_host == app_name)
    else
        id = ID ; ID = ID + 1
        local app = loadfile(name..'.lua')
        local dir
        if not app then
            dir = name
            app = assert(loadfile(name..'/init.lua'))
        end
        app = meta.apply(app)
        local app_env = getfenv(app)
        app = gvt.create(app, {name=name})
        S = { app=app, env=app_env, dir=dir, name=name, host=TODO_HOST }
        SESSIONS[id] = S
        res:set_cookie(name, id)
        if dir then lfs.chdir(dir) end
        gvt.start(app)
        if dir then lfs.chdir('..') end
    end

    -- DATA
    -- TODO: dangerous?
    for var, v in pairs(req.GET) do
        local s1, s2 = acc(S.env, var)
        if string.sub(v, 1, 1) == '!' then
            local v1, v2 = acc(S.env, string.sub(v, 2))
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
