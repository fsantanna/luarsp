local meta = require 'luagravity.meta'

catalog = {
    ball = meta.new{ title='Ball', price=50,  description='A nice Ball', _qtt=0 },
    tv   = meta.new{ title='TV',   price=450, description='A nice TV',   _qtt=0 },
}

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

for k, t in pairs(catalog)
do
    _tot_items = _tot_items.src + t._qtt
    _tot_cost = _tot_cost.src + t._qtt*t.price
    __items = __items.src .. [[
    <tr>
        <td>]]..t.title..[[
        <td>]]..t.description..[[
        <td>]]..t.price..[[
        <td align='right'><input size='2' name='buy.catalog.]]..k..[[._qtt' value=']]..t._qtt..[['>
        <td align='right'>]]..t._qtt*t.price..[[
    </tr>
    ]]
end

