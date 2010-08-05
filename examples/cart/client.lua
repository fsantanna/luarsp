_name  = ''
_addr  = ''
_valid = false

__html_errors = ''
_html = [[
<p>Please, enter your personal data:
<p><form action='client_submit'>
<table>
<tr><td>Name:    <td><input name='client._name' type='text' value=']].._name..[['/></tr>
<tr><td>Address: <td><input name='client._addr' type='text' value=']].._addr..[['/></tr>
<tr><th colspan='2'><input value='Ok!' type='submit'/></tr>
</table>
<p><font color='red'>]]..__html_errors..[[</font>
</form>
]]

spawn(function()
    while true do
        await 'client_submit'
        __html_errors = ''
        _valid = true
        if _name() == '' then
            _valid = false
            __html_errors = __html_errors() .. '<br>Field name is mandatory!'
        end
        if _addr() == '' then
            _valid = false
            __html_errors = __html_errors() .. '<br>Field address is mandatory.'
        end
    end
end)
