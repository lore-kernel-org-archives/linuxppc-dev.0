Date: Tue, 22 Aug 2000 11:42:50 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: daenzerm@student.ethz.ch
cc: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org, dmj+@andrew.cmu.edu
Subject: Re: Control fb problem on 8500
In-Reply-To: <39A23ADB.25E233F@relog.ch>
Message-ID: <Pine.LNX.4.10.10008221141390.377-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 22 Aug 2000, Michel [iso-8859-1] Dänzer wrote:
> Geert Uytterhoeven wrote:
> > On Mon, 21 Aug 2000, Michel [iso-8859-1] Dänzer wrote:
> > > I've thought of this as well. The problem is that the mode hasn't been
> > > initialized when displayWidth is set and used.
> >
> > So the X server initializes the internal screen structures before it even
> > knows that it can use them later?
>
> Yes. This really seems to be a rather serious design flaw - the driver is
> assumed to know at any time whether it can cope with what the user wants and
> how.

Yes indeed.

> Anyway, what do you think about the patch I posted? Michel, can you please try
> it? I don't think having to use ShadowFB with the fbdev driver is too bad
> because it should generally enhance performance :) If the patch is okay, I'll
> submit it to XFree86.

I never read any XFree86 4.0 code.

I know ShadowFB is faster for machines without hardware acceleration. But is
it also faster with hardware acceleration?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
