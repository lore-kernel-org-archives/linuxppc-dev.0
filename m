Date: Mon, 28 Aug 2000 23:35:44 +0300
From: Alex Shnitman <alexsh@hectic.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on Motorola Sandpoint/PPMC7400
Message-ID: <20000828233543.A23949@hectic.net>
References: <20000828225504.B23679@hectic.net> <Pine.HPX.4.10.10008282201290.6537-100000@gra-ux1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.HPX.4.10.10008282201290.6537-100000@gra-ux1.iram.es>; from paubert@iram.es on Mon, Aug 28, 2000 at 10:03:26PM +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Gabriel!

On Mon, Aug 28, 2000 at 10:03:26PM +0200, you wrote the following:

> > Also, is there anything special I should know about booting Linux from
> > dink32? Here's what I did, and how it failed. I got the latest kernel
> > snapshot from fsmlabs (I tried the same with both the latest 2.2 and
> > 2.3 trees). I set in the Makefile ARCH := ppc and CROSS_COMPILE :=
> > powerpc-linux- (the prefix for the tools that I have installed, on my
> > Debian box, from www.emdebian.org). "make menuconfig", there I made
> > sure I have support for serial console, there I also set the boot
> > command line (PReP command line it says) to "console=ttyS0,9600
> > console=ttyS0 root=/dev/ram" (I don't really have initrd yet, I want
> > to see the kernel booting first). Then make zImage, which compiles
> > fine, "file arch/ppc/boot/zvmlinux" tells me it's indeed a PowerPC ELF
> > image, then I zsrec it to an srec file (I tried all kinds of offsets
> > to that offset, and then it just hangs...
>
> You can't start an ELF image from jumping at it sload address. But I know
> only PPCBUG and OF, not your firmware.

But zsrec (the thing that creates the srecords from the binary file)
strips the 64k ELF header of the kernel image, so it should be fine?
Or shouldn't it? Or did I misunderstand you?

If there's something basic that I don't understand, I'll be very happy
with an RTFM link too! The thing is that I've read through the FMs
that I've found and so far it looks to me as if I'm doing it right.

Thanks!


--
Alex Shnitman                            | http://www.debian.org
alexsh@hectic.net, alexsh@linux.org.il   +-----------------------
http://alexsh.hectic.net    UIN 188956    PGP key on web page
       E1 F2 7B 6C A0 31 80 28  63 B8 02 BA 65 C7 8B BA

"Xenix is the pinnacle of modern UNIX design, and will be used for
many years to come."
	-- Xenix OS API manual

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
