Message-Id: <200005060603.PAA08017@mail.cc.tohoku.ac.jp>
MIME-Version: 1.0
Date: Sat, 06 May 2000 15:03:23 +0900
From: Kazunori Aoshima <aoshimak@mail.cc.tohoku.ac.jp>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-fbdev@vuser.vu.union.edu,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: Your message of "Fri, 5 May 2000 13:38:26 +0200 (CEST)"
 	<Pine.LNX.4.10.10005051335010.428-100000@cassiopeia.home>
References: <Pine.LNX.4.10.10005051335010.428-100000@cassiopeia.home>
Subject: Re: PATCH 2.3.99.7.5: update for clgenfb fbdev driver
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Return for :
From: Geert Uytterhoeven <geert@linux-m68k.org>
on " Re: PATCH 2.3.99.7.5: update for clgenfb fbdev driver "
date: Fri, 5 May 2000 13:38:26 +0200 (CEST) >>>

> On Fri, 5 May 2000, Jeff Garzik wrote:
> > updates my cirrus logic fbdev driver with a few cleanups, fix 0xA0000
> > bug (note to alan), module and PCI cleanups, ...
>
> Since clgen_of_init() is exactly the same as clgenfb_init(), and since clgenfb
> uses PCI resource management, can't we simply get rid of the OF specific stuff
> in clgenfb?
>
> Can someone please test this by disabling Offb (CONFIG_FB_OF=n) and seeing
> whether everything still works fine? Thanks!

I would like to test it on my PowerStack.

The test need to test two things.

1. Add clgenfb (Version? I have 1.9.4.4 .) patch on newest
   kernel 2.3.99.7.5 .
2. CONFIG_FB_OF=n and CONFIG_FB_CLGEN=y needs on the config file.

Is that so?

Best regards.
----------------------
Kaz Aoshima = Editor of the PReP station
Material development, Faculty of engineering,
Tohoku University, Japan
E-mail:aoshimak@mail.cc.tohoku.ac.jp
#I would appreciate if you could give me suggestions
 for my impolite English expressions.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
