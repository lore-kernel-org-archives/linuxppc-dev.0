Message-ID: <39B28BB4.A52E1E69@inxpress.net>
Date: Sun, 03 Sep 2000 12:34:44 -0500
From: Stephen B Johnson <stevebj@inxpress.net>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: kernel panic on mcp750
Content-Type: multipart/mixed;
 boundary="------------38A4F3884869AE93C99D4F6F"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------38A4F3884869AE93C99D4F6F
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

I'm observing a kernel panic when booting the kernel on a Motorola
MCP750.  The panic indicates "Kernel panic: No init found.  Try passing
init= option to kernel."

However, I pass init=3 as a parameter.

Any suggestions?



(actual output attached)


--------------38A4F3884869AE93C99D4F6F
Content-Type: text/plain; charset=iso-8859-15;
 name="minicom.cap"
Content-Disposition: inline;
 filename="minicom.cap"
Content-Transfer-Encoding: 7bit


Copyright Motorola Inc. 1988 - 1998, All Rights Reserved

PPC1 Debugger/Diagnostics Release Version 4.1 - 10/12/98 RM01
COLD Start

Local Memory Found =02000000 (&33554432)

MPU Clock Speed =233Mhz

BUS Clock Speed =67Mhz

WARNING: Keyboard Not Connected

Reset Vector Location  : ROM Bank B
Mezzanine Configuration: Single-MPU
Current 60X-Bus Master : MPU0
Idle MPU(s)            : NONE

Initializing System Memory (DRAM)...
System Memory: 32MB, ECC Enabled (ECC-Memory Detected)
L2Cache:       1024KB, 117Mhz

PPC1-Bug>nbo
Network Booting from: DEC21140, Controller 0, Device 0
Device Name: /pci@80000000/pci1011,9@e,0:0,0
Loading: /tftpboot/vm.mcp750

Client IP Address      = 192.168.120.21
Server IP Address      = 192.168.120.1
Gateway IP Address     = 0.0.0.0
Subnet IP Address Mask = 255.255.255.0
Boot File Name         = /tftpboot/vm.mcp750
Argument File Name     =

Network Boot File load in progress... To abort hit <BREAK>

Bytes Received =&574750, Bytes Loaded =&574750
Bytes/Second   =&287375, Elapsed Time =2 Second(s)

Residual-Data Located at: $01F88000
loaded at:     00005400 0001C220
relocated to:  00800000 00816E20
board data at: 01F88000 01F8EA0C
relocated to:  00810314 00816D20
zimage at:     00010400 0008F76D
relocated to:  00817000 0089636D
avail ram:     00400000 00800000

Linux/PPC load: root=nfs rw init=3
Uncompressing Linux...done.
Now booting the kernel
PReP architecture
Total memory = 32MB; using 128kB for hash table (at c0160000)
Linux version 2.2.14 (root@rodan.mvista.com) (gcc version 2.95.2 19991030 (2.95.3 prerelease/franzo)) #1 Tue Aug 8 05:10:51 PDT 2000
Boot arguments: root=nfs rw init=3
OpenPIC Version 1.3 (2 CPUs and 16 IRQ sources) at fc000000
OpenPIC timer frequency is 8333848 Hz
time_init: decrementer frequency = 999993480/60 (15MHz)
Calibrating delay loop... 465.31 BogoMIPS
Memory: 30956k available (856k kernel code, 884k data, 72k init) [c0000000,c2000000]
Dentry hash table entries: 4096 (order 3, 32k)
Buffer cache hash table entries: 32768 (order 5, 128k)
Page cache hash table entries: 8192 (order 3, 32k)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Setting PCI interrupts for a "Mesquite cPCI (MCP750)"
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 32768 bhash 32768)
Initializing RT netlink socket
Starting kswapd v 1.5
initialize_kbd: Keyboard reset failed, no ACK
Serial driver version 4.27 with<4>Keyboard timeout[2]
Keyboard timeout[2]
 no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
VP_IDE: IDE controller on PCI bus 00 dev 59
VP_IDE: 100% native mode on irq 14
    ide0: BM-DMA at 0xffc0-0xffc7, BIOS settings: hda:pio, hdb:pio
ide0: VIA Bus-Master (U)DMA Timing Config Success
    ide1: BM-DMA at 0xffc8-0xffcf, BIOS settings: hdc:pio, hdd:pio
ide1: VIA Bus-Master (U)DMA Timing Config Success
tulip.c:v0.91g-ppc 7/16/99 becker@cesdis.gsfc.nasa.gov
eth0: Digital DS21140 Tulip rev 34 at 0xfffff00, 08:00:3E:2E:54:F1, IRQ 18.
eth0:  EEPROM default media type Autosense.
eth0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
eth0:  MII transceiver #1 config 3000 status 7809 advertising 01e1.
  PCI latency timer (CFLT) is unreasonably low at 0.  Setting to 64 clocks.
Sending BOOTP requests..... OK
IP-Config: Got BOOTP answer from 192.168.120.1, my address is 192.168.120.21
Looking up port of RPC 100003/2 on 192.168.120.1
Looking up port of RPC 100005/1 on 192.168.120.1
VFS: Mounted root (NFS filesystem).
Freeing unused kernel memory: 72k init 8k pmac 12k open firmware
Kernel panic: No init found.  Try passing init= option to kernel.
Rebooting in 180 seconds..

--------------38A4F3884869AE93C99D4F6F--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
