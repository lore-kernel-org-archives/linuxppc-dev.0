Date: Tue, 24 Aug 2004 08:27:03 +0200 (MEST)
From: "Patrick Huesmann" <tricknology@gmx.de>
To: linuxppc-embedded@lists.linuxppc.org
Cc: samlinuxppc@yahoo.com.cn
MIME-Version: 1.0
Subject: Re: How to port ppc-linux to new custom boards? (virtexII)
Message-ID: <18802.1093328823@www32.gmx.net>
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

> Where did you download the Montavista 2_4_devel?

via anonymous rsync from montavista server. i followed the instructions at
http://penguinppc.org/dev/kernel.shtml

>> 1) Is there any comprehensive documentation / tutorial on how to port
>> the ppc-linux to new machines? Where does my board specific fixup
>> stuff go (for example, memory and IRQ declarations and such).
>
>See the following two valuable docs:
>http://www.denx.de/twiki/bin/view/PPCEmbedded/Introduction
>http://www.denx.de/twiki/bin/view/DULG/Manual

Unfortunately, neither of these docs talks about tailoring the kernel to
custom hardware. They only state that "some changes" have to be applied to
the startup code. I need some more specific information, because I'm not a
expert PPC guru.

>> vmlinux file and write it to flash directly, because zImage on powerpc
>> lacks decompressor code (at least with my configuration). But the
>> 1.3meg vmlinux file makes for pretty long turnaround times (I can only
>> upload at 115k at the moment).
>
>AFAIK, the key point of decompressing is boot loader
>itself. It has NOTHING to do with ppc linux. Both
>U-Boot and PlanetCore can do this job well.

this means that i also have to port u-boot and use 2 bootloaders in
sequence, or port u-boot's decompressor code to our own bootloader. Sigh.

Arm Linux provides a self-decompressing zImage. I thought it could be
possible to configure the ppc kernel just like that.

Thanx anyway,
Patrick


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
