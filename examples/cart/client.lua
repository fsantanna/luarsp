__html_errors = ''

_html = [[
<p>Please, enter your personal data:
<p><form action='client_submit'>
<table>
<tr><td>Name:    <td><input name='_name' type='text' value=']].._NAME..[['/></tr>
<tr><td>Address: <td><input name='_addr' type='text' value=']].._ADDR..[['/></tr>
<tr><th colspan='2'><input value='Ok!' type='submit'/></tr>
</table>
<p><font color='red'>]]..__html_errors..[[</font>
</form>
]]

spawn(function()
    while true do
        await 'client_submit'
        __html_errors = ''
        if _NAME() == '' then
            __html_errors = __html_errors() .. '<br>Field name is mandatory!'
        end
        if _ADDR() == '' then
            __html_errors = __html_errors() .. '<br>Field address is mandatory.'
        end
    end
end)
