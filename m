From: "Stefano Coluccini" <s.coluccini@caen.it>
To: "Matt Porter" <mporter@mvista.com>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>,
	"Gabriel Paubert" <paubert@iram.es>
Subject: MVME5100 printouts
Date: Fri, 16 Feb 2001 16:41:49 +0100
Message-ID: <NDBBIFIMCKPOADMAJOKMOEOECOAA.s.coluccini@caen.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Excuse me, I've forget the printouts .....

----------------------------------------------------------------------------
---
Copyright Motorola Inc. 1988 - 2000, All Rights Reserved

PPC6 Debugger/Diagnostics Release Version 1.5 - 08/07/00 RM03
COLD Start

Local Memory Found =04000000 (&67108864)

MPU Clock Speed =450Mhz

BUS Clock Speed =100Mhz

Reset Vector Location  : ROM Bank A
Mezzanine Configuration: Single-MPU
Current 60X-Bus Master : MPU0
Idle MPU(s)            : NONE

L2Cache:       1024KB, 180Mhz
System Memory: 64MB, ECC Enabled (ECC-Memory Detected)

PPC6-Bug>nbo
Network Booting from: I82559, Controller 0, Device 0
Device Name: /pci@fe000000/pci8086,1209@e,0:0,0
Loading: zImage

Client IP Address      = 192.9.200.85
Server IP Address      = 192.9.200.70
Gateway IP Address     = 192.9.200.1
Subnet IP Address Mask = 255.255.255.0
Boot File Name         = zImage
Argument File Name     =

Network Boot File load in progress... To abort hit <BREAK>

Bytes Received =&682495, Bytes Loaded =&682495
Bytes/Second   =&341247, Elapsed Time =2 Second(s)

Residual-Data Located at: $03FA079C
loaded at:     00005400 0001C220
relocated to:  00800000 00816E20
board data at: 03FA079C 03FA71A8
relocated to:  00810314 00816D20
zimage at:     00010F38 000A9166
relocated to:  00817000 008AF22E
avail ram:     00400000 00800000

Linux/PPC load: console=ttyS0,9600 console=tty0 mem=64M
Uncompressing Linux...done.
Now booting the kernel
PReP architecture
Total memory = 64MB; using 256kB for hash table (at c01c0000)
Linux version 2.2.18pre21 (root@totem) (gcc version 2.95.2 19991024
(release)) #
220 Fri Feb 16 16:59:43 CET 2001
Boot arguments: console=ttyS0,9600 console=tty0 mem=64M
OpenPIC Version 1.3 (2 CPUs and 16 IRQ sources) at f3f80000
OpenPIC timer frequency is 4166613 Hz
time_init: decrementer frequency = 1620001800/60 (25MHz)
Calibrating delay loop... 969.93 BogoMIPS
Memory: 62840k available (1020k kernel code, 1568k data, 108k init)
[c0000000,c4
000000]
STE --- after filescache_init
STE --- Entered in dcache_init
STE --- after the kmem_cache_create
STE --- before  get-free-pages: order = 4


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
