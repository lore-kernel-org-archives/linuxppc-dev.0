Message-ID: <399AA354.C0D881D@agelectronics.co.uk>
Date: Wed, 16 Aug 2000 15:21:08 +0100
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: Topi Kanerva <tkanerva@ees2.oulu.fi>
CC: LinuxPPC-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: problems w/ CT69000
References: <Pine.GSO.4.21.0008161454070.5745-100000@stekt6>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Topi Kanerva wrote:

> I'm addressing you folks at ppc-embedded because frankly, I don't know how
> to find any relevant info on this issue. We are developing a single-board
> solution with a CT69000 display controller.

Me too (well, a CT69030). I'm actually using a framebuffer driver for
the chip, rather than the Xserver.

If you're trying the chip on an Intel platfrom, a good first place to
look is Thomas Hhenleitner's driver:
www.visuelle-maschinen.de/ctfb/ctfb0.40.tgz

I've been working on my own 69030 driver, and at some point hope to
merge this with Thomas' driver, and possibly with the existing CT65554
driver in the kernel.

- Adrian Cox, AG Electronics

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
