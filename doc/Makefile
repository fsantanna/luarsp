all: rsp cart
	cat menu.html _rsp.html > index.html
	rm _rsp.html _cart.html

rsp:
	markdown rsp.txt > _rsp.html

cart:
	markdown cart.txt > _cart.html
	cat cart_menu.html _cart.html > cart.html

upload:
	scp doc.css index.html cart.html doc.css rsp.png url.png l.gif \
		francisco@www.lua.inf.puc-rio.br:/home/francisco/public_html/rsp/
