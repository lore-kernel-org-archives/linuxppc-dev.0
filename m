Date: Wed, 27 Sep 2000 13:43:10 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <bh40@calva.net>, Matt Porter <mmporter@home.com>
cc: Olaf Hering <olh@suse.de>,
        Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 with rage II/rage pro -- multi-headed display!
In-Reply-To: <19340821143437.3943@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.10009271341020.383-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 26 Sep 2000, Benjamin Herrenschmidt wrote:
> One thing: I'd be interested in figuring out what happens if you simply
> leave this nasty ATI BAR unassigned (write 0xffffffff and then 0 to it).
> Will the controller fail ?

Well, according to Matt Porter, 0 is a valid address in PCI 2.2. So how do you
disable BARs for PCI 2.2-compliant devices?

And I'm afraid what XFree86 4.x will do with BARs set to 0. Probably it will
try to relocate them. I guess that's how it crashes on my box with an
unitialized S3...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
