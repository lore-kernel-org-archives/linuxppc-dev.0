Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <001301c20060$cb3bf5c0$7301a8c0@zhongqx>
From: "zhongqx" <zhongqx@guoguang.com.cn>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Probelm for linux booting
Date: Tue, 21 May 2002 08:45:06 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
     I have FADS860T board,I want to use ppcboot-1.1.5 to boot linux 2.2.4 kernel.
ppcboot-1.1.5 is ok,but when i use bootm command,
it uncompressed ok and load ramdisk image then nothing happend,  can you meet this
problem before? can you give me some advise? Should I need to change configure file
of FADS860_defconfig ? Console is SMC1 and baudrate is 115200 bps.

=>printenv
bootargs=
bootcmd=bootm 2800100
baudrate=115200
loads_echo=1
clocks_in_mhz=1
ethaddr=00:d0:93:00:12:34
serverip=192.168.1.105
ipaddr=192.168.1.99
stdin=serial
stdout=serial
stderr=serial

Environment size: 187/16380 bytes
=>bdi
memstart    = 0x00000000
memsize     = 0x00800000
flashstart  = 0x02800000
flashsize   = 0x00200000
flashoffset = 0x00044000
sramstart   = 0x00000000
sramsize    = 0x00000000
immr_base   = 0xFF000000
bootflags   = 0x00000001
intfreq     =     48 MHz
busfreq     =     48 MHz
ethaddr     = 00:D0:93:00:12:34
IP addr     = 192.168.1.99
baudrate    = 115200 bps
=>? (May 20 2002 - 14:53:39)

CPU:   XPC860xxZPnnD3 at 48 MHz: 4 kB I-Cache 4 kB D-Cache FEC present
Board: FADS with db MPC821, MPC860 / MPC860SAR / MPC860T rev ENG or PILOT
DRAM:  (4 MB SDRAM)  8 MB
FLASH:  2 MB
In:    serial
Out:   serial
Err:   serial
=>bootm 02880000 02900000
## Booting image at 02880000 ...
   Image Name:   linux-2.4.4 kernel image
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    390207 Bytes = 381 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 02900000 ...
   Image Name:   Simple Ramdisk-Image
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    567988 Bytes = 554 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 006d0000, end 0075aab4 ... OK

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
