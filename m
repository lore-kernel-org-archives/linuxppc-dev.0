Date: Sun, 19 Dec 1999 12:27:17 -0700 (MST)
From: Jeff Rugen <jrugen@primenet.com>
To: linuxppc-workstation@lists.linuxppc.org,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Booting 2.2.x from VGER on PReP
Message-ID: <Pine.BSI.3.96.991219122637.5938A-100000@usr08.primenet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have been trying to get the 2.2.x kernel on VGER booting on my old
Motorola Powerstack (100MHz 604) for a few weeks, and it always seems to
fail right at the start of the boot.  I get the following output when
booting:

-----------------
Restarting system.
VGA already in text mode
loaded at:     05ED4400 05EEB220
relocated to:  00800000 00816E20
board data at: 05F84000 05F8AA0C
relocated to:  00810314 00816D20
zimage at:     05EDF400 05F811A4
avail ram:     00400000 00800000

Linux/PPC load: console=ttyS0,9600 video=clgen:mode:1024x768 partype=ECP
Uncompressing Linux...done.
Now booting the kernel

Exception: Program (Illegal Instruction)
SRR0 =00000004 SRR1 =00080040 Vector-Offset =00700
IP     =00000004 MSR    =00000040 CR     =20000008 FPSCR  =00000000
R0     =0080010C R1     =0080E201 R2     =0080Ab40 R3     =00810314
R4     =00000000 R5     =00000000 R6     =00816D20 R7     =00816D58
R8     =00000000 R9     =00000000 R10    =DEADC0DE R11    =00810000
R12    =00000001 R13    =00000000 R14    =00000000 R15    =00000000
R16    =00000000 R17    =00000000 R18    =00000000 R19    =00000000
R20    =00000000 R21    =00000000 R22    =00000000 R23    =00000000
R24    =00000000 R25    =00000000 R26    =00000000 R27    =00000000
R28    =00000000 R29    =00000000 R30    =00000000 R31    =00000000
SPR0   =00000000 SPR1   =00000000 SPR8   =00000004 SPR9   =00801FC0
00000004 00000000  WORD       $00000000
-----------------------

(The partype=ECP is part of an attempt of mine to add a command-line
parameter to the boot to select ECP, EPP, or SP parallel port, though the
code that sets which type to use is commented out.  The code itself worked
on a previous version some time ago though).

Does anyone have any suggestions on things to try to get more info about
where the boot is dying, or any patches to suggest?  Thanks for any help.

----------------------------------------------------------------------------
Jeff Rugen                      jrugen@primenet.com

...Had this been an actual emergency, we would have fled in terror, and you 
would not have been informed.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
