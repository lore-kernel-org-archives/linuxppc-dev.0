Date: Wed, 7 Nov 01 15:00:35 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0111072300.AA06602@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: RFC: i8259.c cleanup
Cc: Sven.Dickert@planb.de, davidm@amberdata.demon.co.uk,
	geert@linux-m86k.org, hollis@austin.ibm.com, paubert@iram.es
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> But because you have 2 cascaded i8259s it's more complex to poll both i8259s
> than to read the single magic interrupt acknowledge register.

True, an Interrupt Acknowledge cycle is more efficient than polling. I guess we
could make two versions of the 8259 code, one using the more efficient
Interrupt Acknowledge cycle and the other using polling for machines that don't
support interrupt acknowledge.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
