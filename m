Date: Sun, 8 Feb 2004 14:19:49 -0800
From: Brad Boyer <flar@allandria.com>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [linux-mac68k] Re: drivers/macintosh/Kconfig (was: Re: Linux 2.6.3-rc1)
Message-ID: <20040208221948.GA14225@pants.nu>
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org> <Pine.GSO.4.58.0402081436370.2443@waterleaf.sonytel.be> <20040208205734.GA13906@pants.nu> <20040208220710.GA5933@kiste>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040208220710.GA5933@kiste>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Feb 08, 2004 at 11:07:10PM +0100, Matthias Urlichs wrote:
> This may be a stupid question, but I've got an iMate, and it already
> works rather well -- it checks whether the (single!) ADB device behind
> it is a keyboard or a mouse, and then translates that to standard PCish
> USB keycodes or mouse events, transparently.

Yes, it can convert a standard keyboard and mouse directly to a USB
keyboard and mouse, but if you want to treat it as a generic ADB
bus, you need a driver.

> Do you have documentation that says it can do more ..?

How about the official page?

http://www.griffintechnology.com/products/imate/

It specifically says "and other ADB peripherals" in the description.
The various documentation if you search around their site talks
about how you can just plug in a keyboard or mouse and it works,
but has a driver download for OSX and OS9 to allow using anything
with a real ADB driver to work.

I'm pretty sure keyboards and mice are the only devices currently
supported on ADB in Linux anyway, but it's a thought for the future.

	Brad Boyer
	flar@allandria.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
