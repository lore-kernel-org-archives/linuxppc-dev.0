Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3ECBB43B.2000601@yahoo.co.jp>
Date: Thu, 22 May 2003 02:15:39 +0900
From: digitalRNA <horizonprits@yahoo.co.jp>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: u-boot-0.3.0 + Linux boot failed on walnut
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

Now I am trying to boot Linux using u-boot-0.3.0 not openbios on walnut.
But it failed.
It looks failed around timer initialization on vmlinux.
But in the case of openbios, the Linux can boot.
Are there any information about this issue?


U-Boot 0.3.0 (May 15 2003 - 18:47:55)
CPU:   IBM PowerPC 405GP Rev. C at 200 MHz (PLB=100, OPB=50, EBC=33 MHz)
PCI sync clock at 33 MHz, internal PCI arbiter enabled
16 kB I-Cache 8 kB D-Cache
Board: ### No HW ID - assuming WALNUT405
I2C:   ready
DRAM:  32 MB
FLASH: 512 kB
In:    serial
Out:   serial
Err:   serial
KGDB:  kgdb ready
ready
BEDBUG:ready
Hit any key to stop autoboot:  0
=>                                                                              => tftpboot 0x100000 pImage
ENET Speed is 100 Mbps - FULL duplex connection
ARP broadcast 1
TFTP from server 9.188.9.24; our IP address is 9.188.9.204
Filename 'pImage'.
Load address: 0x100000
Loading: #################################################################               ###########################################################            done
Bytes transferred = 630421 (99e95 hex)
=> bootm 0x100000
## Booting image at 00100000 ...
Image Name:   Linux-2.4.18_mvl30-walnut
Created:      2003-05-19   6:00:19 UTC
Image Type:   PowerPC Linux Kernel Image (gzip compressed)
Data Size:    630357 Bytes = 615.6 kB
Load Address: 00000000
Entry Point:  00000000
Verifying Checksum ... OK
Uncompressing Kernel Image ... OK

(stop: but cpu is running around timer_interrupt on vmlinux)


405GP 1.15 ROM Monitor (8/9/00)                                                                                                                                  --------------------- System Info ----------------------
Processor         = 405GP,   PVR: 40110082
Processor speed   = 200 MHz
PLB speed         = 100 MHz
OPB speed         = 50 MHz
Ext Bus speed     = 33 MHz
PCI Bus speed     = 33 MHz (Sync)
Amount of SDRAM   = 32 MBytes
Internal PCI arbiter enabled                                                    --------------------------------------------------------                                                                                                        --- Device Configuration ---
Power-On Test Devices:
000  Disabled  System Memory [RAM]
001  Enabled   Ethernet      [ENET]
004  Disabled  Serial Port 2 [S2]                                             ----------------------------
Boot Sources:
001  Enabled   Ethernet      [ENET]                                                            local=9.188.9.204  remote=9.188.9.24  hwaddr=0004ace30fea
004  Disabled  Serial Port 2 [S2]                                                              local=8.1.1.2  remote=255.255.255.255  hwaddr=ffffffffffff
005  Enabled   Serial Port 1 [S1]
Baud = 115200
----------------------------
Debugger: Disabled                                                              ----------------------------
1 - Enable/disable tests
2 - Enable/disable boot devices
3 - Change IP addresses
4 - Ping test
5 - Toggle ROM monitor debugger
6 - Toggle automatic menu
7 - Display configuration
8 - Save changes to configuration
9 - Set baud rate for s1 boot
A - Enable/disable I cache (Enabled )
B - Enable/disable D cache (Disabled)
0 - Exit menu and continue
->0                                                                                                                                                             EMAC0 Ethernet Test OK.
ENET Speed is 100 Mbs...
FULL duplex connection
Booting from [ENET] Ethernet     ...
Sending bootp request ...
ENET: hold frame collision, outbound frame.                                                                                                                                                                                                     Loading file "/tftpboot/walnut-linuz" ...
Sending tftp boot request ...
Transfer Complete ...
Loaded successfully ...
Entry point at 0x500000 ...                                                                                                                                     loaded at:     00500000 005AE1F8
relocated to:  00400000 004AE1F8
board data at: 004AB128 004AB168
relocated to:  0040546C 004054AC
zimage at:     00405A1C 004AAD3E
avail ram:     004AF000 02000000                                                                                                                                Linux/PPC load: root=/dev/nfs rw ip=on
Uncompressing Linux....
Now booting the kernel
Linux version 2.4.18_mvl30-walnut (xxx) (gcTIBM Walnut (IBM405GP) Platform
...

can boot.

Regards,

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
