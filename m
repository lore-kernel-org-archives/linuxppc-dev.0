From: "Matthias Urlichs" <smurf@smurf.noris.de>
Date: Sun, 8 Feb 2004 23:39:31 +0100
To: Brad Boyer <flar@allandria.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [linux-mac68k] Re: drivers/macintosh/Kconfig (was: Re: Linux 2.6.3-rc1)
Message-ID: <20040208223930.GA6456@kiste>
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org> <Pine.GSO.4.58.0402081436370.2443@waterleaf.sonytel.be> <20040208205734.GA13906@pants.nu> <20040208220710.GA5933@kiste> <20040208221948.GA14225@pants.nu>
Mime-Version: 1.0
In-Reply-To: <20040208221948.GA14225@pants.nu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Brad Boyer:
> [ Link to the manufacturer ]

Ah. Thanks.

> I'm pretty sure keyboards and mice are the only devices currently
> supported on ADB in Linux anyway, but it's a thought for the future.

OK, so ... (playing around with the thing a bit more) yep, an ADB driver
for it would actually make sense.

Two reasons: One, the Mac keyboards habitually send the same keycodes
for left and right modifier keys, and if you want to distinguish them,
say to use one for ALT and the other for AltGr, you need to send some
special ADB commands; the iMate doesn't do that when it's emulating a
PC keyboard.

Two, people who use their ol' Mac mouse (or trackball...) typically want
to plug it into the keyboard, instead of buying a second iMate. ;-)


If somebody would kindly send two spare weeks or so my way, I'll happily
write one...

--
Matthias Urlichs

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
