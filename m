Return-Path: <BenoitL@adept.com>
Received: from srv-mail-1.adept.com (unknown [12.195.90.243])
	by ozlabs.org (Postfix) with ESMTP id 1932B679E0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 22 Jul 2006 05:05:08 +1000 (EST)
Message-ID: <D3A60B685BD79544ACA481B73FA81EA02F4F27@COBALT>
From: Benoit Lajoie-Dorval <BenoitL@adept.com>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: Boot problem on Sandpoint 
Date: Fri, 21 Jul 2006 11:49:14 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all, 
I have to port Linux on a Sandpoint Board wtih a MPC8241 processor on. I
built a kernel using linux 2.6.15 and create an zImage.initrd.elf with a
ramdisk. All of this (linux and ramdisk) was packaged with ELDK 4.0. I also
minimized everything in the .config file to only have what is really
necessary (serial port, 6xx processor, etc). The communication is made with
the board by its internal serial port and Dink32 is used to do everything
else. 

The problem is that when I execute the loaded zImage.initrd.elf, the boot
sequence just hangs there and I just don't see anything happening. There is
nothing that is displayed. I know that the elf file as an offset header of
0X10000, so the problem is not there. I also put some breakpoints and trace
using Dink32 to see where it stops and it may have something to do with the
disable_6xx_mmu in the utils.S file.  

I just really don't know what's wrong in my config and I hope someone could
help me on this.  

Thank you

Benoit Lajoie-Dorval
