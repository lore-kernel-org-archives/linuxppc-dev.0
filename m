Date: Fri, 31 Aug 2001 11:16:29 +0200
From: Xavier Grave <grave@ipno.in2p3.fr>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Xavier Grave <grave@ipno.in2p3.fr>,
	embarque ppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mvme5100 one more time...
Message-ID: <20010831111629.A29808@ipnpcu5.in2p3.fr>
References: <20010830170043.A8047@ipnpcu5.in2p3.fr> <20010830091936.N18618@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
In-Reply-To: =?ISO-8859-1?Q?=3C20010830091936=2EN18618=40cpe-24-221-152-185=2Eaz=2Esp?=
 =?ISO-8859-1?Q?rintbbd=2Enet=3E=3B_from_trini=40kernel=2Ecrashing=2Eorg_?=
 =?ISO-8859-1?Q?on_jeu=2C_ao=FB_30=2C_2001_at_18:19:36_+0200?=
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Le jeu, 30 aoû 2001 18:19:36, Tom Rini a écrit :
>
> On Thu, Aug 30, 2001 at 05:00:43PM +0200, Xavier Grave wrote:
>
> > I have compiled the last 2.4.10-pre1 kernel from linuxppc_2_4_devel
> > and I try to do a :
> > ppc6bug> nbo 0 0 ,,, zImage.pplus
> >
> > The only thing I have is the following :
> > Exception : Program (Illegal instruction)

> What CPU is this?  I'm assuming you get a register dump, can you post
> that
> too?

I recompiled a kernel with the mvme5100_defconfig, the only difference is
that  CONFIG_PPC_STD_MMU=y is set

The error is the following :
Loading: zImage.pplus

Client IP Address      = 192.168.120.38
Server IP Address      = 192.168.120.35
Gateway IP Address     = 0.0.0.0
Subnet IP Address Mask = 255.255.255.0
Boot File Name         = zImage.pplus
Argument File Name     =

Network Boot File load in progress... To abort hit <BREAK>

Bytes Received =&701581, Bytes Loaded =&701581
Bytes/Second   =&701581, Elapsed Time =1 Second(s)

Exception: Program (Illegal Instruction)
SRR0 =001F0000 SRR1 =00083040 Vector-Offset =00700
IP     =001F0000 MSR    =00003040 CR     =00000000 FPSCR  =00000000
R0     =00000000 R1     =03F00000 R2     =00000000 R3     =00000000
R4     =00000000 R5     =49504C01 R6     =00007000 R7     =001F0000
R8     =03F0CF54 R9     =03F0CD54 R10    =03F0CD60 R11    =03F0CE54
R12    =03F0CE54 R13    =00000000 R14    =00000000 R15    =00000000
R16    =00000000 R17    =00000000 R18    =00000000 R19    =00000000
R20    =00000000 R21    =00000000 R22    =00000000 R23    =00000000
R24    =00000000 R25    =00000000 R26    =00000000 R27    =00000000
R28    =00000000 R29    =00000000 R30    =00000000 R31    =00000000
SPR0   =00000000 SPR1   =00000000 SPR8   =00000000 SPR9   =00000000
001F0000 00040000  WORD        $00040000

I will have a new try without the MMU CONFIG set...

xavier
--
33 (0) 1 69 15 79 59
De chacun selon ses forces, a chacun selon ses besoins

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
