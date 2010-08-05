--docroot = lfs.currentdir()
local docroot = '..'
local rsp = dofile(docroot .. '/rsp.lua')

rules = {
  {
    match = { "^/rsp$", "^/rsp/" },
    with = wsapi.xavante.makeHandler(rsp, "/rsp", docroot, docroot)
  },


  { -- wsapihandler
    match = {"%.lua$", "%.lua/" },
    with = wsapi.xavante.makeGenericHandler (docroot, { isolated = true })
  },
  { -- filehandler
     match = ".",
     with = xavante.filehandler,
     params = { baseDir = docroot }
  }
}
