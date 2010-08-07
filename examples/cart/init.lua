local meta = require 'luagravity.meta'

local _assert, _tonumber, _tostring = L(assert), L(tonumber), L(tostring)

CATALOG = dofile 'catalog.lua'

pub = meta.new {
    qtt   = meta.new{},
    _page = 'buy',
    _name  = '',
    _addr  = '',
}
for k, t in pairs(CATALOG) do
    pub.qtt['_'..k] = 0
end

QTT = meta.new{}
for k, v in meta.pairs(pub.qtt) do
    QTT[k] = _assert(_tonumber(v))
end

_NAME = _assert(_tostring(pub._name))
_ADDR = _assert(_tostring(pub._addr))

buy    = meta.dofile('buy.lua',    _M)
client = meta.dofile('client.lua', _M)
status = meta.dofile('status.lua', _M)

_page = OR( AND(EQ(pub._page, 'buy'), buy._html),
            OR( AND(EQ(pub._page, 'client'), client._html),
                OR( AND( EQ(pub._page, 'status'), status._html), 'invalid page' )))

_html = [[
<html>
<body>
<center>
<table width='80%' border='0' cellspacing='0'>
<tr>
    <td width='20%' valign='top'>
    <ul>
        <b>Menu:</b>
        <li><a href="nop?_page=buy">   Buy   </a>
        <li><a href="nop?_page=client">Client</a>
        <li><a href="nop?_page=status">Status</a>
        <li><a href="quit">            Quit  </a>
    </ul>            </td>
    <td width='80%' valign='top'>]].._page..[[</td>
</tr>    
</table>
</center>
</body>
</html>
]]

await 'quit'

_html = [[Goodbye!]]
