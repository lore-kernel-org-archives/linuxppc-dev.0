Date: Mon, 22 Oct 2001 22:26:54 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Tony 'Nicoya' Mantler" <nicoya@apia.dhs.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: idebus=133 ?
In-Reply-To: <20011022194702.1461@smtp.wanadoo.fr>
Message-ID: <Pine.GSO.4.21.0110222225100.22580-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 22 Oct 2001, Benjamin Herrenschmidt wrote:
> >I thought Apple put a 66MHz PCI slot in some G3 systems for the video card,
> >before switching to AGP.
>
> Hehe... in fact, when I wrote the previous email, I had that, then
> decided it was just bloat to say that as nobody use it for anything
> but video ;)
>
> >Of course, it's usually filled with a video card rather than an IDE card,
> >but who knows how some people might want to reconfigure their systems.
>
> Well. I don't even know if it's really a 66Mhz slot, or some kind of
> hacked 33Mhz with a doubled clock (I don't know if it really follow
> the PCI spec for 66Mhz). I heard noise when the machine was released
> about that slot not beeing completely standard.

I once heard the electrical stuff is 66 MHz, but the connector is mounted
differently so only the custom OEM cards from ATI will fit. That's what you can
call `user lock-in' :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
