Message-ID: <A109131318C4D1119AC20060088DECE330F3E9@MAIL>
From: Lucinda Schafer <lucsch@adaptivemicro.com>
To: Patrick Lerda <Lerda@microprocess.com>,
        "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: MMU problems on Linux 8xx. (reliability...)
Date: Mon, 19 Jun 2000 11:29:42 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Are you using a standard or custom board? Our MPC823-based custom board
crashes occasionally on a page fault or other memory management related
routine. We always get the kernel mode FPU software emulation panic. It
seems that you are experiencing the same problem as we are.

It is interesting that you see this work on a PPC750 but not PPC823. Dan
states that there are no instructions that are not supported by the 823
implemented in the Linux kernel; but a problem with the 32 TLB versus 8(??)
hasn't been addressed, although that seems too obvious.

We are very frustrated at this point, as we are working towards a
manufacturable product. A kernel panic is not acceptable--it's a show
stopper!

We are going to go back to the BSE-IP board and run similar tests on both
the Monta Vista and standard, patched kernels, (2.2.13) to "see" if it's
related to our hardware and/or the kernel we are running.

Any suggestions are welcome.

Lucinda Schafer
Staff Software Engineer
Adaptive Micro-Ware, Inc.

-----Original Message-----
From: Patrick Lerda [mailto:Lerda@microprocess.com]
Sent: Wednesday, June 14, 2000 4:11 AM
To: 'linuxppc-embedded@lists.linuxppc.org'
Subject: MMU problems on Linux 8xx. (reliability...)



I've a PPC823 board working with a recent linux kernel based on monta vista.
When I try complex operation like compiling a kernel on this board, the
kernel
crash after a while. An illegal instruction is generated, linux see
an opcode: *NIP=0, the illegal instruction occur in a glibc-2.1.3 page.
The glibc page is not see properly... This problem seems to occur
only on complex operation, and make this system not reliable.

I also have a PPC750 board working with the same kernel with proper
configuration,
the only differences in code is the MMU part. Linux work properly and
reliably
on this board with the PPC860 software.

if you have see a similar behaviour on you boards, or with differents
processor.
I know that the PPC823 is not 100% compatible with the PPC860, there is
some differences on TLB available etc... And linux seems to be hard coded
for 32 TLB...

If you know how the MMU is handle on linux 8xx, and if you see a similar
behavior
let me know...



Patrick LERDA


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
