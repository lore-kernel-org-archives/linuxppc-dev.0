Message-Id: <200211290048.SAA31687@lists.linuxppc.org>
From: "=?GB2312?Q?=D3=DA=E6=BA?=" <yuj@mail.ndsc.com.cn>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: zynx zx212 dual-port ethernet card
Mime-Version: 1.0
Content-Type: text/plain
Date: Fri, 29 Nov 2002 8:52:18 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The start information is list below:
//////////////////////////////////
Copyright Motorola Inc. 1988 - 2001, All Rights Reserved

PPC5 Debugger/Diagnostics Release Version 1.3 - 04/27/2001 RM01
COLD Start

Local Memory Found =20000000 (&536870912)

MPU Clock Speed =400Mhz

BUS Clock Speed =100Mhz

Reset Vector Location  : ROM Bank B
Mezzanine Configuration: Single-MPU
Current 60X-Bus Master : MPU0
Idle MPU(s)            : NONE

L2Cache:       2048KB, 200Mhz
Initializing System Memory (DRAM)...
L2Cache:       2048KB, 200Mhz
System Memory: 512MB, ECC Enabled (ECC-Memory Detected)


SelfTest/Boots about to Begin... Press <BREAK> at anytime to Abort ALL

NetBoot about to Begin... Press <ESC> to Bypass, <SPC> to Continue

Network Booting from: I82559, Controller 0, Device 0
Device Name: /pci@fec00000/pci8086,1209@e,0:0,0
Loading: vmlinuz-motorola-lopec

Client IP Address      = 192.168.201.3
Server IP Address      = 192.168.201.1
Gateway IP Address     = 0.0.0.0
Subnet IP Address Mask = 255.255.255.0
Boot File Name         = vmlinuz-motorola-lopec
Argument File Name     =

Network Boot File load in progress... To abort hit <BREAK>

Bytes Received =&784800, Bytes Loaded =&784800
Bytes/Second   =&392400, Elapsed Time =2 Second(s)

Residual-Data Located at: $1FED16DC
loaded at:     00005400 000C65BC
relocated to:  00800000 008C11BC
zimage at:     00805A00 008BD53E
avail ram:     00400000 00800000

Linux/PPC load: ip=on
Uncompressing Linux...done.
Now booting the kernel

/////////////////////////////
Have you solved your problem now?

>Sir, I am having a similar issue with an Intel network board on an MCP750 >board. How far does the kernel get, where does it stop?



>   I'm porting hardhat linux v2.1 on my motorola lopec mpc7410 board with a zynx zx212 dual-port ethernet card on it.The problem is that the kernel can't start up with the ethernet card on,while without it everything is perfect.Since zx212 is compatible with 21143,I build the kernel with the "tulip" option on.It should be no problem,but it happened.Can anybody tell me the reason?
> 　　　　　　　　yuj@mail.ndsc.com.cn
> 　　　　　　　　　　2002-11-14
>
>

　　　　　　　　yuj@mail.ndsc.com.cn
　　　　　　　　　　2002-11-26

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
