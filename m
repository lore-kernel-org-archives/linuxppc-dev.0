Message-ID: <3913818B.F7F3927E@mandrakesoft.com>
Date: Fri, 05 May 2000 22:20:59 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: linux-fbdev@vuser.vu.union.edu,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PATCH 2.3.99.7.5: update for clgenfb fbdev driver
References: <Pine.LNX.4.10.10005051335010.428-100000@cassiopeia.home>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
>
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

If I can find someone to test, it can definitely be removed.  Thanks for
noticing..

	Jeff



--
Jeff Garzik              | ILOVEYOU, Linux.
Building 1024            |
MandrakeSoft, Inc.       |

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
