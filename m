Message-ID: <A109131318C4D1119AC20060088DECE330F452@amwmail.adaptivemicro.com>
From: Lucinda Schafer <lucsch@adaptivemicro.com>
To: Michael Coy <mac12@po.cwru.edu>, linuxppc-embedded@lists.linuxppc.org
Subject: RE: PCMCIA ATA flash support?
Date: Tue, 20 Jun 2000 10:44:12 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I assume the patches you are using are for the problems described in

http://lists.linuxppc.org/listarcs/linuxppc-embedded/199912/msg00018.html

If not, you might read that one..

Lucinda Schafer
Staff Software Engineer
Adaptive Micro-Ware, Inc.

-----Original Message-----
From: Michael Coy [mailto:mac12@po.cwru.edu]
Sent: Tuesday, June 20, 2000 8:29 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: PCMCIA ATA flash support?



I'm trying to get PCMCIA support working on Montavista's Hardhat linux and
an RPX lite (MPC 823).  The PC card I'm using is a SanDisk ATA flashdisk,
if that makes a difference.

I've got the patches from absoval.com and followed all the instructions in
their doc.  I also have read the PCMCIA howto.

I can insmod the pcmcia drivers, and a cardctl ident does identify the
card to be a SunDisk fixed disk.

But as soon as I start cardmgr to attach the IDE device, I get:
kernel panic: Kernel Mode Software FPU Emulation

I've tried compiling the kernel both with and without FPU emulation, and
I've also tried changing the memory addresses, as suggested by the PCMCIA
howto.  I even tried replacing the card.  Nothing seems to make a
difference.

Any suggestions would be greatly appreciated.
Thanks,
mike


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
