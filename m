Message-ID: <000b01c31f5a$fcfc80b0$346ab796@corebellhychon>
From: =?ks_c_5601-1987?B?wPzH/b+1?= <hychon@corebell.co.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: how to kernel booting on MCP750 board
Date: Wed, 21 May 2003 14:36:42 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello!!

I'm porting mvista linux-2.4.2 on the motorola mpc750 board.
But it's not good working, It's occur Exception.
Its error message is attach at below.

Of course, I have read some manual (about PPC-Bug and MCP750 Booting).
But I don't know why it is not good working?

Can you tell me some advices about "how to make a kernel image" and "how to booting kernel image"
I want to know configuration information for download and booting with kernel  at  PPC-BUG.

Thanks you for read


-----------ERROR----------------------
Copyright Motorola Inc. 1988 - 1997, All Rights Reserved
PPC1 Debugger/Diagnostics Release Version 3.4 - 12/03/97 RM01
COLD Start
Local Memory Found =02000000 (&33554432)
MPU Clock Speed =233Mhz
BUS Clock Speed =67Mhz
WARNING: Keyboard Not Connected

Reset Vector Location  : ROM Bank B
Mezzanine Configuration: Single-MPU
Current 60X-Bus Master : MPU0
Idle MPU(s)            : NONE

System Memory: 32MB, ECC Enabled (ECC-Memory Detected)
L2Cache:       1024KB, 117Mhz

PPC1-Bug>
PPC1-Bug>
PPC1-Bug>nbo 0 0 10.10.10.2 10.10.10.1 vmlinux.bin
Network Booting from: DEC21140, Controller 0, Device 0
Device Name: /pci@80000000/pci1011,9@e,0:0,0
Loading: vmlinux.bin

Client IP Address      = 10.10.10.2
Server IP Address      = 10.10.10.1
Gateway IP Address     = 0.0.0.0
Subnet IP Address Mask = 255.0.0.0
Boot File Name         = vmlinux.bin
Argument File Name     =

Network Boot File load in progress... To abort hit <BREAK>

Bytes Received =&1445904, Bytes Loaded =&1445904
Bytes/Second   =&481968, Elapsed Time =3 Second(s)

Residual-Data Located at: $01F88000

Exception: Program (Illegal Instruction)
SRR0 =A6440000 SRR1 =00083040 Vector-Offset =00700
IP     =A6440000 MSR    =00003040 CR     =00000000 FPSCR  =00012000
R0     =00000000 R1     =01F88000 R2     =00000000 R3     =01F88000
R4     =00005000 R5     =00000000 R6     =00000000 R7     =00000000
R8     =00000000 R9     =00000000 R10    =00000000 R11    =00000000
R12    =00000000 R13    =00000000 R14    =00000000 R15    =00000000
R16    =00000000 R17    =00000000 R18    =00000000 R19    =00000000
R20    =00000000 R21    =00000000 R22    =00000000 R23    =00000000
R24    =00000000 R25    =00000000 R26    =00000000 R27    =00000000
R28    =00000000 R29    =00000000 R30    =00000000 R31    =00000000
SPR0   =00100500 SPR1   =00000000 SPR8   =00000000 SPR9   =00000000
A6440000 02F20C63  WORD        $02F20C63
PPC1-Bug>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
