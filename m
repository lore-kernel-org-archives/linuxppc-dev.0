Date: Sun, 8 Feb 2004 17:00:36 -0600
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Brad Boyer <flar@allandria.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [linux-mac68k] Re: drivers/macintosh/Kconfig (was: Re: Linux 2.6.3-rc1)
Message-ID: <20040208230036.GB11808@permusion.kilzer.net>
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org> <Pine.GSO.4.58.0402081436370.2443@waterleaf.sonytel.be> <20040208205734.GA13906@pants.nu> <20040208211510.GH25453@permusion.kilzer.net> <Pine.GSO.4.58.0402082314330.8349@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.58.0402082314330.8349@waterleaf.sonytel.be>
From: ddkilzer@kilzer.net (David D. Kilzer)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Feb 08, 2004 at 11:16:30PM +0100, Geert Uytterhoeven wrote:
> On Sun, 8 Feb 2004, David D. Kilzer wrote:
> > NeXT workstations (which are also m68k-based) contain ADB hardware, so
> > it's not Macintosh-specific.
>
> Care to resurrect the NeXT port of Linux/m68k?

Actually, I bought a complete NeXT system (I think it was a slab) 3-4
years ago for this very purpose, but I haven't even unpacked it yet. :)

I've also got an HP 9000/425e (kbd and mouse, but no monitor), and at
least half a dozen old m68k Macs in my basement.

And I started on a port of uClinux to non-MMU m68k-based Macs 3-4
years ago using a Mac SE with 8 MB RAM an ethernet card.  I managed to
build a working Penguin booter for System 7 and a linux-2.0.38 uClinux
kernel, but the combination never got to userland (although I did get
serial console output through 'POSIX conformance testing by UNIFIX',
then the kernel tried to initialize the MMU and went into an endless
loop).

First things first, though.  I need to get a cross-dev environment set
up that works (or at least that I trust).  I have yet to build a 2.2
kernel (from mac68k CVS) or a 2.4 kernel (from m68k CVS) that will boot
to userland on my Quadra 660av!  The last working kernel I have for it
is 2.2.16 from mac68k CVS.

Dave

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
