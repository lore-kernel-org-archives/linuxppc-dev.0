Message-ID: <40C4DBA3.1090202@nortelnetworks.com>
Date: Mon, 07 Jun 2004 17:18:27 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: problems with 2.6.5 and MCPL765
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We've been using 2.4.22 with Motorola MCPN765 cards, and are looking at moving
to 2.6.5.  We took a userspace image that worked on 2.4, stuck it into
arch/ppc/boot/images and did a "make zImage.initrd" at the top level of the
2.6.5 kernel tree with the processor set to 74xx and the platform set to
MCPN765.  Is that the right way to do it? (I realize that userspace might have
issues, but for a first crack at it, should that at least start to run?)

We then tried to boot and immediately took the following exception:

Exception: Alignment
SRR0 =00499234 SRR1 =00002040 Vector-Offset =00600
DSISR=00002467 DAR  =FFFF92F3
IP     =00499234 MSR    =00002040 CR     =20000044 FPSCR  =00000000
R0     =0080013C R1     =0158A0D0 R2     =0000000F R3     =00500000
R4     =00000000 R5     =00000000 R6     =00000000 R7     =00000000
R8     =0048D7B8 R9     =00000000 R10    =00001014 R11    =00000008
R12    =00000001 R13    =000000FF R14    =00000000 R15    =00000000
R16    =00000000 R17    =00000000 R18    =00000000 R19    =00000000
R20    =00000000 R21    =00000000 R22    =00000000 R23    =00000000
R24    =00000000 R25    =00000000 R26    =00000000 R27    =00000000
R28    =00000000 R29    =00000000 R30    =00000000 R31    =00500000
SPR0   =EFFEA298 SPR1   =00000000 SPR8   =00000028 SPR9   =00000000
00499234 C86792F3  LFD         FR3,$FFFF92F3(R7) ($FFFF92F3)
PPC6-Bug>Console = [1F: VT- "SLAVE"]

Any ideas where to look?

Thanks,

Chris

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
