From: "chendong" <dong_chen@jetronic.com.cn>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: what 's wrong with the kernel booting?
Mime-Version: 1.0
Content-Type: text/plain
Date: Tue, 13 May 2003 16:17:56 +0800
Message-Id: <20030513082339.VRHT16484.lcfep4.online.sh.cn@chendong>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,all
 I port uboot0.2.0 in my 405Gpr board.But I got some problems when
booting kernel.Have anyone gave some advice?
		Thanks
		wood

tftp 0x200000
ENET Speed is 100 Mbps - FULL duplex connection
ARP broadcast 1
Got good ARP - start TFTP
TFTP from server 192.168.0.83; our IP address is 192.168.0.2
Filename 'zImage.treeboot'.
Load address: 0x200000
Loading: #################################################################
	 ##############################################
done
Bytes transferred = 568052 (8aaf4 hex)
=> tfp 0x100000
ENET Speed is 100 Mbps - FULL duplex connection
ARP broadcast 1
Got good ARP - start TFTP
TFTP from server 192.168.0.83; our IP address is 192.168.0.2
Filename 'zImage.treeboot'.
Load address: 0x100000
Loading: *#################################################################
	 ##########
done
Bytes transferred = 379656 (5cb08 hex)
=> bootm 0x100000 0x200000
## Booting image at 00100000 ...
   Image Name:   Powerpc Linux Kernel
   Created:      2003-05-09  15:01:24 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    379592 Bytes = 370.7 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x00F8F580 => set upper limit to 0x00800000
## cmdline at 0x007FFC00 ... 0x007FFC0D
bd address  = 0x00F8FF90
memstart    = 0x00000000
memsize     = 0x01000000
flashstart  = 0xFFF80000
flashsize   = 0x00080000
flashoffset = 0x00040000
sramstart   = 0x00000000
sramsize    = 0x00000000
bootflags   = 0x7FFFFF00
procfreq    =    400 MHz
plb_busfreq =    100 MHz
pci_busfreq = 33.333 MHz
ethaddr     = 00:D0:59:B8:36:C0
IP addr     = 192.168.0.2
baudrate    =   9600 bps
## Loading RAMDisk Image at 00200000 ...
   Image Name:   Simple Ramdisk-Image
   Created:      2001-05-13  10:49:23 UTC
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    567988 Bytes = 554.7 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## initrd at 0x00200040 ... 0x0028AAF3 (len=567988=0x8AAB4)
   Loading Ramdisk to 00f04000, end 00f8eab4 ... OK
## Transferring control to Linux (at address 00000000) ...
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:mapin_ram done
MMU:setio
MMU:exit
setup_arch: enter
setup_arch: bootmem
arch: exit

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
