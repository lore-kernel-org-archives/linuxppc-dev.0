Date: Mon, 13 Aug 2001 16:58:12 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Derrik Pates <dpates@dsdk12.net>
Cc: Iain Sandoe <iain@sandoe.co.uk>,
	Derrik Pates <demon@devrandom.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Fix for PPC audio devices that can't reendianize samples
In-Reply-To: <Pine.LNX.4.33.0108130805450.24665-100000@andromeda.dsdk12.net>
Message-ID: <Pine.LNX.4.05.10108131657301.21541-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 13 Aug 2001, Derrik Pates wrote:
> On Sun, 12 Aug 2001, Iain Sandoe wrote:
> > Well, actually, I'd like to lose all the translation stuff (rate conversion,
> > format conversion etc.).  This belongs in User-Land and is preventing me
> > from implementing mmio (which would be useful for the more serious
> > applications).
>
> Ok, so why not just take it out, and have the driver printk() a message if
> userspace tries to force it to accept an audio format it doesn't know,
> saying basically, "Please ask the developers of the software to properly
                                                  ^^^^^^^^^^^^
You can even printk() the name of the program.

> query the OSS device for supported formats"? If that's really the way
> you'd prefer it to be, really nothing else is going to make people sit up
> and pay attention other than just saying "Ok, this behavior is now broken,
> not just deprecated, but BROKEN".

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
