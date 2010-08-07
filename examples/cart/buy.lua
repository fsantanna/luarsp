local meta = require 'luagravity.meta'

_tot_items = 0
_tot_cost  = 0

__items = ''

_html = [[
<form>
<table width='80%' border=1 cellspacing=0>
    <tr>
        <th>Item
        <th>Description
        <th>Price
        <th>#
        <th>Total
    </tr>
]] .. __items .. [[
    <tr>
        <td><br>
        <td><br>
        <td><br>
        <td align='right'>]].._tot_items..[[
        <td align='right'>]].._tot_cost..[[
    </tr>
    <tr><th colspan=5><input type='submit' value='ok'/></tr>
</table>
</form>
]]

for k, t in pairs(CATALOG)
do
    k = '_'..k
    local _qtt = QTT[k]
    _tot_items = _tot_items.src + _qtt
    _tot_cost = _tot_cost.src + _qtt*t.price
    __items = __items.src .. [[
    <tr>
        <td>]]..t.title..[[
        <td>]]..t.description..[[
        <td align='right'>]]..t.price..[[
        <td align='right'><input size='2' name='qtt.]] ..k.. [[' value=']] .._qtt.. [['>
        <td align='right'>]].._qtt*t.price..[[
    </tr>
    ]]
end

