Date: Mon, 28 Aug 2000 22:03:26 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Alex Shnitman <alexsh@hectic.net>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on Motorola Sandpoint/PPMC7400
In-Reply-To: <20000828225504.B23679@hectic.net>
Message-ID: <Pine.HPX.4.10.10008282201290.6537-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 28 Aug 2000, Alex Shnitman wrote:

	Hi,

> Also, is there anything special I should know about booting Linux from
> dink32? Here's what I did, and how it failed. I got the latest kernel
> snapshot from fsmlabs (I tried the same with both the latest 2.2 and
> 2.3 trees). I set in the Makefile ARCH := ppc and CROSS_COMPILE :=
> powerpc-linux- (the prefix for the tools that I have installed, on my
> Debian box, from www.emdebian.org). "make menuconfig", there I made
> sure I have support for serial console, there I also set the boot
> command line (PReP command line it says) to "console=ttyS0,9600
> console=ttyS0 root=/dev/ram" (I don't really have initrd yet, I want
> to see the kernel booting first). Then make zImage, which compiles
> fine, "file arch/ppc/boot/zvmlinux" tells me it's indeed a PowerPC ELF
> image, then I zsrec it to an srec file (I tried all kinds of offsets
> -- does it matter?), then I upload it to the PowerPC box, then I "go"
> to that offset, and then it just hangs...

You can't start an ELF image from jumping at it sload address. But I know
only PPCBUG and OF, not your firmware.

	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
