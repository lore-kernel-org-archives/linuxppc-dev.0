Message-Id: <200211140848.CAA19190@lists.linuxppc.org>
From: "=?GB2312?Q?=D3=DA=E6=BA?=" <yuj@mail.ndsc.com.cn>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: motorola lopec mpc7410
Mime-Version: 1.0
Content-Type: text/plain
Date: Thu, 14 Nov 2002 16:50:34 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi!
 I'm porting mvista linux 2.1 for the motorola lopec mpc7410 board.And I noticed that there are some differences between the board version described by mvista and motorola.Also,the version of PPCBug is different.I'm wondering why?
 Does anyone have encounter the problem before?Here is my board starting information:
///////////
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
System Memory: 512MB, ECC Enabled (ECC-Memory Detected)

PPC5-Bug>CNFG
Board (PWA) Serial Number = "6016204     "
Board Identifier          = "LoPEC-P011      "
Artwork (PWA) Identifier  = "01-W3646F11B    "
MPU Clock Speed           = "400"
BUS Clock Speed           = "100"
Ethernet Address          = 0001AF0996C8
Primary SCSI Identifier   = "07"
System Serial Number      = "0               "
System Identifier         = "0                              "
License Identifier        = "6016204  "
//////////////////

When I port the mvista linux v2.1(motorola lopec 74xx lsp),the starting information is showed below:

//////////////
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

///////////////////////////////////////////////////////////////////////////

After  "Now booting the kernel",there is nothing put on the screen.I don't know why?Can anybody help me?
　　　　　　　　yuj@mail.ndsc.com.cn
　　　　　　　　　　2002-11-14

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
