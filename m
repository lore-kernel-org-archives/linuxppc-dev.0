Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "nagraj c" <cn_raju@hotmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: linux hangs after MMU:mapin
Date: Thu, 01 Jan 2004 12:05:51 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law15-F93QzWsfdg29l00008f3e@hotmail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

      "Wish You A Happy New Year".

      I am trying to port Linux on PPC405GP. I have downloaded
linuxppc_2_4_devel using BitKeeper and compiled using powerpc-linux- tools.
And I followed the following steps to compile kernel.
      make walnut_config
      make mrproper
      make menuconfig
      make dep
      make uImage

      After exucuting final step, vmlinux.UBoot has been created in
/linuxppc_2_4_devel/arch/ppc/boot/images.
      Boot Loader: I am using U-BOOT-0.4.0 as a boot loader.
      Board: Custom Board with IBM walnut405 features.

      U-BOOT is working fine. I have downloaded vmlinux.UBoot into 0x400000
memory location using tftp command. After I boot linux using command bootm
400000, it hangs after
PPC:> bootm 400000
## Booting image at 00400000 ...
   Image Name:   Linux-2.4.23
   Created:      2003-12-23  10:11:20 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    258050 Bytes = 252 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin

        What could be the problem? Any suggestions are apreciated.

        My board info is as follows:

PPC:> bd_info
memstart    = 0x00000000
memsize     = 0x04000000
flashstart  = 0xFFF80000
flashsize   = 0x00480000
flashoffset = 0x0002D000
sramstart   = 0x00000000
sramsize    = 0x00000000
bootflags   = 0x0000A000
procfreq    = 266.660 MHz
plb_busfreq = 133.330 MHz
pci_busfreq = 33.332 MHz
ethaddr     = 00:01:01:01:01:01
IP addr     = 192.168.0.204
baudrate    = 9600 bps
	And environment variables are set as follows:
PPC:> printenv
bootcmd=bootm F0400000
loads_echo=1
ethaddr=00:01:01:01:01:01
bootdelay=50
filesize=80000
ipaddr=192.168.0.204
serverip=192.168.0.65
baudrate=115200
bootflags=0x00000001
bootargs=root=/dev/ram0 rw
stdin=serial
stdout=serial
stderr=serial

Environment size: 238/65532 bytes

With Best Regards,
Nag

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
