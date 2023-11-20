local fs   = require 'bee.filesystem'
local time = require 'bee.time'

collectgarbage('generational', 10, 50)

package.path = package.path.. ';./?.lua;./?/init.lua'

require 'luals'

--语言服务器自身的状态
---@class LuaLS.Runtime
luals.runtime = require 'runtime'

fs.create_directories(fs.path(luals.runtime.logPath))

---@diagnostic disable-next-line: lowercase-global
log = New 'Log' {
    clock = function ()
        return time.monotonic() / 1000.0
    end,
    time  = function ()
        return time.time() // 1000
    end,
    path = luals.uri.decode(luals.runtime.logUri) .. '/test.log',
}

---@class Test
test = {}
test.catch = require 'test.catch'
test.rootPath = luals.runtime.rootPath .. '/test_root'
test.rootUri  = luals.uri.encode(test.rootPath)
test.fileUri  = luals.uri.encode(test.rootPath .. '/unittest.lua')
