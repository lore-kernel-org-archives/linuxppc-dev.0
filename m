Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <09C1525B7197D3118A4D0008C7E6EEE00FD74787@zuk28exm05.ecid.cig.mot.com>
From: Latsky Sterren-LTSS001 <LTSS001@motorola.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: UART Problems booting linux on est8260
Date: Wed, 11 Aug 2004 13:51:02 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi.

I'm trying to boot linux-2.4.22 on the est8260 board using U-boot-1.1.1, but the serial interface corrupts after this line comes up:

=> bootm
## Booting image at 00400000 ...
   Image Name:   Linux 2.4.22
   Created:      2004-08-10  15:55:04 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    523580 Bytes = 511.3 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Memory BAT mapping: BAT2=16Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.22 (ltss001@linux) (gcc version 2.95.3 20010315 (release)) #3
..
Kernel command line: root=/dev/nfs rw nfsroot=192.168.0.1:/tftpboot/192.168.0.2
ip=192.168.0.2:192.168.0.1::255.255.255.0::off panic=1
...
CPM UART driver version 0.01

I have looked around and found that the next line should say something like

ttyS00 at 0x8000 is a SCC

But all I get is garbage like musical notes and square root signs streaming onto the terminal. I have tried changing the baud rate when this comes up to all the other options but I still don't read anything coherent.

When configuring the kernel I tried just loading the est8260_config, then building without editing the menuconfig, when that didn't work I went to menuconfig > Character devices and fiddled around with various options in there but nothing seems to work.

Any help would be greatly appreciated. Thanks,
Sterren Latsky

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
