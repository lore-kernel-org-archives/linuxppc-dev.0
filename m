Message-Id: <5.1.0.14.0.20011121090126.034c0480@pop.gmx.de>
Date: Wed, 21 Nov 2001 09:07:19 +0800
To: Alex Zeffertt <ajz@cambridgebroadband.com>
From: Michael Habermann <MHabermann@gmx.de>
Subject: Re: Abatron BDI2000
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <3BFA8C23.465CD6B1@cambridgebroadband.com>
References: <A3E34B558F5CD211B4980008C7A4A99003C5853A@sparrow.gso.mcs.marconi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 05:00 PM 11/20/2001 +0000, Alex Zeffertt wrote:
>   BDI> load vmlinux image
>   Loading vmlinux , please wait ....
>   - File offset 0x00010000 to address 0xC0000000 size 6946844
>   # PPC: interrupt indication received (may be bus error)
>
>In the BDi2000 manual (section 3.3.4) it says you need to "Load the
>compressed linux image".  But I
>couldn't find any way to build vmlinuz for the PPC architecture.  As far
>as I'm aware this is only a
>valid target when ARCH=i386.

I do it in this way:
1. Flashing PPCBoot as bootloader using the BDI
2. Boot the PPCBoot which then loads the kernel via TFTP.

In most cases using Linux, you don't need to write an image into RAM using
the BDI. Also 0xc000000 is a virtual adress. You have to pass the BDI a
physical memory address. The Bus error means that no memory or device is
connected at 0xc000000.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
