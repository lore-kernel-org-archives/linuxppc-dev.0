Date: Sun, 8 Feb 2004 12:57:34 -0800
From: Brad Boyer <flar@allandria.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: drivers/macintosh/Kconfig (was: Re: Linux 2.6.3-rc1)
Message-ID: <20040208205734.GA13906@pants.nu>
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org> <Pine.GSO.4.58.0402081436370.2443@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.58.0402081436370.2443@waterleaf.sonytel.be>
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
> And probably we want to move a few more options from arch/m68k/Kconfig to
> drivers/macintosh/Kconfig.

I've started rewriting ADB for the new driver model, and I have been
putting it into a new directory, drivers/adb/. Seeing this makes me
wonder if that's what people think is the best idea. We could have
ADB support on non-Mac machines at some point. I'll try to get the
Griffin iMate (a UDB-ADB converter) working at some point, although
the built-in interfaces take priority for me. The hydra chip is
technically not in any Mac either, although it's very much a Mac
oriented chip. I personally think drivers/macintosh/ should be
limited to things like macio-*, mediabay, and other similar stuff.
Anyone care to comment?

	Brad Boyer
	flar@allandria.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
