Subject: Re: drivers/macintosh/Kconfig (was: Re: Linux 2.6.3-rc1)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brad Boyer <flar@allandria.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040208205734.GA13906@pants.nu>
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org>
	 <Pine.GSO.4.58.0402081436370.2443@waterleaf.sonytel.be>
	 <20040208205734.GA13906@pants.nu>
Content-Type: text/plain
Message-Id: <1076275785.885.94.camel@gaston>
Mime-Version: 1.0
Date: Mon, 09 Feb 2004 08:29:46 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I've started rewriting ADB for the new driver model, and I have been
> putting it into a new directory, drivers/adb/.

Ah, good to know, as I was about to do it too ! Though I don't
fully agree with moving it to a new directory.

> Seeing this makes me
> wonder if that's what people think is the best idea. We could have
> ADB support on non-Mac machines at some point.

What for ? NeXT cubes ? :)

> I'll try to get the
> Griffin iMate (a UDB-ADB converter) working at some point, although
> the built-in interfaces take priority for me. The hydra chip is
> technically not in any Mac either, although it's very much a Mac
> oriented chip. I personally think drivers/macintosh/ should be
> limited to things like macio-*, mediabay, and other similar stuff.
> Anyone care to comment?

Well... via-pmu at least is a lot more than just an ADB host
driver and should stay in drivers/macintosh. But if we go that way,
then it make little sense to have via-pmu and via-cuda in different
locations..

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
