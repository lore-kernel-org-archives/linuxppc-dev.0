Date: Sun, 8 Feb 2004 08:53:26 -0600
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: drivers/macintosh/Kconfig (was: Re: Linux 2.6.3-rc1)
Message-ID: <20040208145326.GC25453@permusion.kilzer.net>
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org> <Pine.GSO.4.58.0402081436370.2443@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.58.0402081436370.2443@waterleaf.sonytel.be>
From: ddkilzer@kilzer.net (David D. Kilzer)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Feb 08, 2004 at 03:25:50PM +0100, Geert Uytterhoeven wrote:
> On Fri, 6 Feb 2004, Linus Torvalds wrote:
> > Benjamin Herrenschmidt:
> >   o ppc32: Use drivers/Kconfig and move some Mac stuffs to
> >     drivers/macintosh/Kconfig
>
> And of course we just started to use drivers/Kconfig on m68k in CVS ;-)
>
> This patch is a first attempt to fix the issues. What do you think?
>
> ADB_CUDA is shared between m68k and PPC. Anyone who knows which m68k
> models use it, so we can list them in the help text?

According to arch/m68k/mac/config.c:

Color Classic
Mac TV
Performa 475
Performa 520
Performa 550
Performa 575
Performa 588
Quadra 605
Quadra 630
Quadra/Centris 660AV
Quadra 840AV

Dave

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
