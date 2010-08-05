local meta = require 'luagravity.meta'

buy    = meta.dofile 'buy.lua'
client = meta.dofile 'client.lua'
status = meta.dofile 'status.lua'

_page = buy._html

_html = [[
<html>
<body>
<center>
<table width='80%' border='0' cellspacing='0'>
<tr>
    <td width='20%' valign='top'>
    <ul>
        <b>Menu:</b>
        <li><a href="nop?_page=!buy._html">   Buy   </a>
        <li><a href="nop?_page=!client._html">Form  </a>
        <li><a href="nop?_page=!status._html">Status</a>
        <li><a href="quit">                   Quit  </a>
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
