From: "Matthias Urlichs" <smurf@smurf.noris.de>
Date: Sun, 8 Feb 2004 23:07:10 +0100
To: Brad Boyer <flar@allandria.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [linux-mac68k] Re: drivers/macintosh/Kconfig (was: Re: Linux 2.6.3-rc1)
Message-ID: <20040208220710.GA5933@kiste>
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org> <Pine.GSO.4.58.0402081436370.2443@waterleaf.sonytel.be> <20040208205734.GA13906@pants.nu>
Mime-Version: 1.0
In-Reply-To: <20040208205734.GA13906@pants.nu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Brad Boyer:
> ADB support on non-Mac machines at some point. I'll try to get the
> Griffin iMate (a UDB-ADB converter) working at some point, although
> the built-in interfaces take priority for me.

This may be a stupid question, but I've got an iMate, and it already
works rather well -- it checks whether the (single!) ADB device behind
it is a keyboard or a mouse, and then translates that to standard PCish
USB keycodes or mouse events, transparently.

Do you have documentation that says it can do more ..?

>                I personally think drivers/macintosh/ should be limited
> to things like macio-*, mediabay, and other similar stuff. Anyone care
> to comment?

I tend to agree.

--
Matthias Urlichs

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
