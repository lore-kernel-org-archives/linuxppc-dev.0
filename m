Date: Mon, 28 Aug 2000 22:55:04 +0300
From: Alex Shnitman <alexsh@hectic.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Linux on Motorola Sandpoint/PPMC7400
Message-ID: <20000828225504.B23679@hectic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I've seen that Hard Hat Linux supports the Sandpoint board with
MPC8240 and MPC755. We have a 7400 processor there though. Does anyone
have any experience with this configuration? Can Linux run on it?

Also, is there anything special I should know about booting Linux from
dink32? Here's what I did, and how it failed. I got the latest kernel
snapshot from fsmlabs (I tried the same with both the latest 2.2 and
2.3 trees). I set in the Makefile ARCH := ppc and CROSS_COMPILE :=
powerpc-linux- (the prefix for the tools that I have installed, on my
Debian box, from www.emdebian.org). "make menuconfig", there I made
sure I have support for serial console, there I also set the boot
command line (PReP command line it says) to "console=ttyS0,9600
console=ttyS0 root=/dev/ram" (I don't really have initrd yet, I want
to see the kernel booting first). Then make zImage, which compiles
fine, "file arch/ppc/boot/zvmlinux" tells me it's indeed a PowerPC ELF
image, then I zsrec it to an srec file (I tried all kinds of offsets
-- does it matter?), then I upload it to the PowerPC box, then I "go"
to that offset, and then it just hangs...

Any ideas what to try? I'm simply lost...

Thanks a lot in advance!


--
Alex Shnitman                            | http://www.debian.org
alexsh@hectic.net, alexsh@linux.org.il   +-----------------------
http://alexsh.hectic.net    UIN 188956    PGP key on web page
       E1 F2 7B 6C A0 31 80 28  63 B8 02 BA 65 C7 8B BA

Make it idiot-proof and someone will make a better idiot.
	-- Mikko Hänninen

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
