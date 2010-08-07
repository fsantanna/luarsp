__valid = AND( NEQ(_NAME, ''), NEQ(_ADDR, '') )

_html = [[
<ul>
    <li>Personal data: ]]..OR(AND(__valid, 'OK!'), 'PENDING...')..[[
    <li>Shopping Cart: ]]..buy._tot_items..[[ items = $ ]]..buy._tot_cost..[[
</ul>
]]
