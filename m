MIME-Version: 1.0
Content-Type: text/plain
Subject: PMC card problem
Date: Fri, 18 Jul 2003 11:25:12 +0800
Message-ID: <7A7A7A38134E244784EDAC428C538AE92A5782@mail.ndsc.com.cn>
From: =?gb2312?B?09rmug==?= <yujing@ndsc.com.cn>
To: <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!
  I'm porting mvista linux2.1 on my motorola lopec mpc7410 board with a
zynx zx212 dual-port ethernet card on it.The problem is that the kernel
can't start up with the ethernet card on,while without it everything
is perfect.Since zx212 is compatible with 21143,I build the kernel
with the "tulip" option on.It should be no problem,but it happened.
It halts after "now booting the kernel". Zx212 is a PMC network card
with Intel 21143 and Intel PCI Bridge 21152. Through the bdi2000,
it seems that there are something wrong with "setup_arch",and maybe
"pciauto_bus_scan".But I'm not sure. Maybe you can help me.

The booting information outlined below :
////////
Copyright Motorola Inc. 1988 - 2001, All Rights Reserved

PPC5 Debugger/Diagnostics Release Version 1.3 - 04/27/2001 RM01 COLD Start

Local Memory Found =10000000 (&268435456)

MPU Clock Speed =400Mhz

BUS Clock Speed =100Mhz

Reset Vector Location  : ROM Bank B
Mezzanine Configuration: Single-MPU
Current 60X-Bus Master : MPU0
Idle MPU(s)            : NONE

L2Cache:       2048KB, 200Mhz
System Memory: 256MB, ECC Enabled (ECC-Memory Detected)


SelfTest/Boots about to Begin... Press <BREAK> at anytime to Abort ALL

NetBoot about to Begin... Press <ESC> to Bypass, <SPC> to Continue

Network Booting from: I82559, Controller 0, Device 0
Device Name: /pci@fec00000/pci8086,1209@e,0:0,0
Loading: yujing-bdi

Client IP Address      = 172.168.201.3
Server IP Address      = 172.168.201.100
Gateway IP Address     = 172.168.201.100
Subnet IP Address Mask = 255.255.0.0
Boot File Name         = yujing-bdi
Argument File Name     =

Network Boot File load in progress... To abort hit <BREAK>

Bytes Received =&886652, Bytes Loaded =&886652
Bytes/Second   =&443326, Elapsed Time =2 Second(s)

Residual-Data Located at: $0FED16DC
loaded at:     00005400 000D1C20
relocated to:  00800000 008CC820
zimage at:     00805A00 008C8183
avail ram:     00400000 00800000

Linux/PPC load: ip=on
Uncompressing Linux...done.
Now booting the kernel
//////
after that, nothing appears.

Best Regard
Yu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
