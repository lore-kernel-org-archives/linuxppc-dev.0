Date: Mon, 22 Oct 2001 17:46:55 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michael Clark <michael@metaparadigm.com>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Late Broadcom link detection makes IP config (bootp) fail
In-Reply-To: <20011022084148.G4933@cpe-24-221-152-185.az.sprintbbd.net>
Message-ID: <Pine.GSO.4.21.0110221746280.29422-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 22 Oct 2001, Tom Rini wrote:
> On Mon, Oct 22, 2001 at 03:16:36PM +0200, Benjamin Herrenschmidt wrote:
> > >Okay, changed to BMAC and it works okay - should BMAC detection come
> > >before GMAC?
> >
> > There is no way bmac would replace gmac, those are different drivers
> > for different chips.
>
> But would bmac ever try and init some gmac hw?  That's sort of what it
> sounded like Michael was saying.  But anyhow, gmac and bmac use the
> module_init bits and thus there's no way to enforce ordering of init.

... except for changing the order in the Makefile.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
