Date: Tue, 20 Jun 2000 09:29:08 -0400 (EDT)
From: Michael Coy <mac12@po.cwru.edu>
To: linuxppc-embedded@lists.linuxppc.org
Subject: PCMCIA ATA flash support?
Message-ID: <Pine.GSO.4.10.10006200914350.12085-100000@amazon>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
