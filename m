Date: Sun, 8 Feb 2004 15:15:10 -0600
To: Brad Boyer <flar@allandria.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [linux-mac68k] Re: drivers/macintosh/Kconfig (was: Re: Linux 2.6.3-rc1)
Message-ID: <20040208211510.GH25453@permusion.kilzer.net>
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org> <Pine.GSO.4.58.0402081436370.2443@waterleaf.sonytel.be> <20040208205734.GA13906@pants.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040208205734.GA13906@pants.nu>
From: ddkilzer@kilzer.net (David D. Kilzer)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


NeXT workstations (which are also m68k-based) contain ADB hardware, so
it's not Macintosh-specific.

I guess it is company-founded-by-Steve-Jobs specific, though.  :)

Dave


On Sun, Feb 08, 2004 at 12:57:34PM -0800, Brad Boyer wrote:

> I've started rewriting ADB for the new driver model, and I have been
> putting it into a new directory, drivers/adb/. Seeing this makes me
> wonder if that's what people think is the best idea. We could have
> ADB support on non-Mac machines at some point. I'll try to get the
> Griffin iMate (a UDB-ADB converter) working at some point, although
> the built-in interfaces take priority for me. The hydra chip is
> technically not in any Mac either, although it's very much a Mac
> oriented chip. I personally think drivers/macintosh/ should be
> limited to things like macio-*, mediabay, and other similar stuff.
> Anyone care to comment?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
