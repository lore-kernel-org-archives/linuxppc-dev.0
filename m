Date: Wed, 7 Nov 2001 10:31:40 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Dan Malek <dan@mvista.com>
Cc: hollis@austin.ibm.com,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	davidm@amberdata.demon.co.uk, Sven.Dickert@planb.de
Subject: Re: RFC: i8259.c cleanup
In-Reply-To: <3BE8D69D.5020600@mvista.com>
Message-ID: <Pine.GSO.4.21.0111071030490.11631-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 7 Nov 2001, Dan Malek wrote:
> hollis@austin.ibm.com wrote:
> > The following patch (to linuxppc_2_4_devel) does exactly that - it reads from
> > 0xbffffff0 instead of the 8259 directly.
>
> Ummmmm.....this probably works OK on PReP, but I don't think it is going
> to have the desired effect on other systems using an 8259 :-).  You need
> to find a way to to make the code you changed unique to PReP.

Note that CHRP already has such a thing (chrp_int_ack_special), to be used with
OpenPIC (it's passed to openpic_init()).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
