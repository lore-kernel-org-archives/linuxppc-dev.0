Message-ID: <000601c32006$5222a280$346ab796@corebellhychon>
From: =?ks_c_5601-1987?B?wPzH/b+1?= <hychon@corebell.co.kr>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <000b01c31f5a$fcfc80b0$346ab796@corebellhychon> <3ECBC077.2030903@mvista.com>
Subject: Re: how to kernel booting on MCP750 board
Date: Thu, 22 May 2003 11:03:15 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks your answer.
But you are misunderstand my-Question,

I'm working that is booting kernel on MCP750 target board.
But it not do good working. it's display following error.

I using the kernel source(v2.4.2) from CDK2.0  and compile is OK.
But when I execute "boot" command, it is occur exception error.

=== Error Message ==============
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
================================

I think that it problem are either bad compile kernel image or bad
download and execute address.

As you say, If it alreay done,  Can you give me sample kernel image
or tell me reference sites.

----- Original Message -----
From: "Mark A. Greer" <mgreer@mvista.com>
Sent: Thursday, May 22, 2003 3:07 AM
Subject: Re: how to kernel booting on MCP750 board

> ÀüÇý¿µ wrote:
>
> >I'm porting mvista linux-2.4.2 on the motorola mpc750 board.
> >
> Why? Its already done.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
