Message-ID: <20040824013046.12837.qmail@web15609.mail.cnb.yahoo.com>
Date: Tue, 24 Aug 2004 09:30:46 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
Subject: Re: How to port ppc-linux to new custom boards? (virtexII)
To: Patrick Huesmann <tricknology@gmx.de>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <23479.1093274235@www38.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Patrick Huesmann <tricknology@gmx.de> wrote£º

> I'm trying to port Linux to a custom board built around a
> virtexII-fpga which features a PPC-405 cpu.
>
> I've downloaded the Montavista 2_4_devel tree, which

Where did you download the Montavista 2_4_devel?
Recently, I need to upgrade the kernel on RPXlite DW.

> already has some platform and driver support for the ml300 eval
[snip]

> 1) Is there any comprehensive documentation / tutorial on how to port
> the ppc-linux to new machines? Where does my board specific fixup
> stuff go (for example, memory and IRQ declarations and such).

See the following two valuable docs:

http://www.denx.de/twiki/bin/view/PPCEmbedded/Introduction

http://www.denx.de/twiki/bin/view/DULG/Manual

> 2) What requirements and responsibilities are imposed on the
> bootloader? I suspect that I can't use u-boot or something like that,
> because we have our own "company-specific" bootloader so that all our
> products use the same protocol for firmware updates.

Maybe this is your next problem exits.

> 3) Is there a way to get a self-decompressing kernel image? ARM linux
> provides a zImage which the cpu just has to jump into (with some
> registers initialized) and then decompresses vmlinux by itself. Now I
> have to use a

ARM Linux can do like this. PPC Liunx also can make
it. :-)

> vmlinux file and write it to flash directly, because zImage on powerpc
> lacks decompressor code (at least with my configuration). But the
> 1.3meg vmlinux file makes for pretty long turnaround times (I can only
> upload at 115k at the moment).

AFAIK, the key point of decompressing is boot loader
itself. It has NOTHING to do with ppc linux. Both
U-Boot and PlanetCore can do this job well.

Best regards,

Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
