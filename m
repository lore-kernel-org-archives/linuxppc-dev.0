Date: Fri, 5 Jan 2001 16:20:06 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michel Dänzer <michdaen@iiic.ethz.ch>
cc: Iain Sandoe <iain@sandoe.co.uk>, linuxppc-dev@lists.linuxppc.org
Subject: Re: problems when recompiling dmasound modules
In-Reply-To: <3A55E402.DA790B96@iiic.ethz.ch>
Message-ID: <Pine.LNX.4.05.10101051619530.634-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 5 Jan 2001, Michel Dänzer wrote:
> Iain Sandoe wrote:
> > > so they rely on `make oldconfig' and `make dep' instead...
> >
> > vi Makefile, change EXTRAVERSION to append -ids (my usual kinda practice)...
> >
> > make oldconfig dep vmlinux modules
> >
> >  - builds dmasound_core & dmasound_awacs
> >
> > make_install creates a new /lib/modules/2.4.0-test13-pre3-ids and the
> > modules appear to be installed...
> >
> > so... it seems to work for me.
>
> The problem only shows up when I boot the new kernel and try to insmod the
> dmasound modules, have you tried that?
>
>
> If make dep is always needed after make oldconfig that may be the problem as I
> also rely on make oldconfig telling me if I have to do that. (real men, you
> know ;)

I always do make dep after make oldconfig.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
