Date: Wed, 7 Nov 2001 22:26:34 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	Sven.Dickert@planb.de, davidm@amberdata.demon.co.uk,
	hollis@austin.ibm.com, Gabriel Paubert <paubert@iram.es>
Subject: Re: RFC: i8259.c cleanup
In-Reply-To: <0111072122.AA06299@ivan.Harhan.ORG>
Message-ID: <Pine.GSO.4.21.0111072225300.10862-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 7 Nov 2001, Michael Sokolov wrote:
> hollis@austin.ibm.com wrote:
> > Would you say poking the 8259 directly is more "right" than using 0xbffffff0
> > (or equivalent)?
>
> Both methods are equally right. However, the polling method requires knowledge
> only of the 8259s, which is required anyway, while the other method requires
> knowledge of the interrupt acknowledge mechanism. It is also possible for
> somebody to design a machine with 8259s without any interrupt acknowledge
> mechanism at all, the 8259 datasheet will tell you that it has been designed
> for such applications as well.

But because you have 2 cascaded i8259s it's more complex to poll both i8259s
than to read the single magic interrupt acknowledge register.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
