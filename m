Date: Wed, 7 Nov 01 14:55:43 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0111072255.AA06565@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: RFC: i8259.c cleanup
Cc: Sven.Dickert@planb.de, davidm@amberdata.demon.co.uk,
	geert@linux-m68k.org, hollis@austin.ibm.com, paubert@iras.es
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> That address is passed by board-specific code to the generic OpenPIC code
> during OpenPIC initialization.

What does it have to do with OpenPIC? It's the 8259 code, if it's changed to
use interrupt acknowledge, that will need this information.

> So s/an openpic/another interrupt controller/.
>
> There's no single reason why you can't pass a magic interrupt acknowledge
> address to the initialization code for the Adirondack interrupt controller.
>
> Well, this assumes you have generic `building block' interrupt controller code
> that can be cascaded arbitrarily by board-specific code.

Well, if/when you change the 8259 code to use interrupt acknowledge, you'll
have to provide an interface allowing ports to tell it how to do it. When that
happens I'll make the Adirondack and K2 ports provide this information.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
