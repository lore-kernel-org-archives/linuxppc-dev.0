Message-ID: <39861265.FFE62C6F@mvista.com>
Date: Mon, 31 Jul 2000 16:57:25 -0700
From: Johnnie Peters <jpeters@mvista.com>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        Michel Dnzer <daenzerm@student.ethz.ch>,
        Tony Mantler <nicoya@apia.dhs.org>,
        Tom Rini <trini@kernel.crashing.org>, Dan Malek <dan@netx4.com>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_PPC != Mac
References: <200007301648.RAA16700@hyperion.valhalla.net>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:

> On  Sun, Jul 30, 2000,  Geert Uytterhoeven wrote:
> > On Sun, 30 Jul 2000, Michel [iso-8859-1] Dänzer wrote:
> >> Geert Uytterhoeven wrote:
> >> > The Master PPC Penguin decided to no longer allow to build machine specific
> >> > kernels, but treat PowerMac/PReP/MTX/CHRP as one big machine type
> >> > (`CONFIG_ALL_PPC').
> [snip]
> > Personally I'd more like a configuration where you can select whatever you
> > want of
> >
> >   - PowerMac (CONFIG_PMAC)
> >   - PReP (CONFIG_PREP)
> >   - MTX (CONFIG_MTX)
> >   - CHRP (CONFIG_CHRP)
> >   - Gemini (CONFIG_GEMINI)
> >   - EST8260 (CONFIG_EST8260)
> >   - APUS (CONFIG_APUS)
> >
> > with of course some extra logic to prevent illegal combinations.
>
> This would definitely get my vote too.  There are too many cases where you
> can enable conflicting build options at present - it causes much
> frustration.
>
> Iain.
>

There are also other considerations.  While there is almost always enough memory to

carry the extra functionality it is not always the case.  Some boards are being
booted
out of rom and may still only have a limited amount of space to hold the kernel.
In any
case do we really want to wast the space.

As Dan stated it also causes a lot of extra work on ports to new boards that
probably
do not need all the configuration parameters for the pmacs.

Johnnie

MontaVista Software, Inc.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
