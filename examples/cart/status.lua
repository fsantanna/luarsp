_html = [[
<ul>
    <li>Personal data: ]]..OR(AND(client._valid, 'OK!'), 'PENDING...')..[[
    <li>Shopping Cart: ]]..buy._tot_items..[[ items = $ ]]..buy._tot_cost..[[
</ul>
]]
