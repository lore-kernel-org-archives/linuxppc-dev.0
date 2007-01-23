Return-Path: <bounces@nabble.com>
Received: from talk.nabble.com (www.nabble.com [72.21.53.35])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 91FDADDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Jan 2007 15:17:47 +1100 (EST)
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50) id 1H9D6C-0000zR-BI
	for linuxppc-embedded@ozlabs.org; Mon, 22 Jan 2007 20:17:32 -0800
Message-ID: <8515241.post@talk.nabble.com>
Date: Mon, 22 Jan 2007 20:17:32 -0800 (PST)
From: Nethra <nethra_gmit@yahoo.co.in>
To: linuxppc-embedded@ozlabs.org
Subject: linux booting using ramdisk
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


hi,
 I am using MPC8272ADS board.I am getting fallowing error for kernel
booting...
=> printenv
bootdelay=5
baudrate=115200
ethact=FCC2 ETHERNET
filesize=23a19c
fileaddr=300000
ipaddr=192.168.174.231
serverip=192.168.178.110
ethaddr=00:99:23:44:ad:de
stdin=serial
stdout=serial
stderr=serial
bootargs=root=/dev/ram

Environment size: 219/262140 bytes
=> tftpboot 0x400000 8272ADS_ramdisk_img
Using FCC2 ETHERNET device
TFTP from server 192.168.178.110; our IP address is 192.168.174.231
Filename '8272ADS_ramdisk_img'.
Load address: 0x400000
Loading: #################################################################
         #################################################################
         #######################################################
done
Bytes transferred = 942521 (e61b9 hex)
=> tftpboot 0x500000 ramdisk.new
Using FCC2 ETHERNET device
TFTP from server 192.168.178.110; our IP address is 192.168.174.231
Filename 'ramdisk.new'.
Load address: 0x500000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         ###################
done
Bytes transferred = 2758997 (2a1955 hex)
=> bootm 0x400000 0x500000
## Booting image at 00400000 ...
   Image Name:   Linux-2.6.10_mvl401-8272ads
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    942457 Bytes = 920.4 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 00500000 ...
   Image Name:   uImage.ramdisk
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    2758933 Bytes =  2.6 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 038e6000, end 03b87915 ... OK
Linux version 2.6.10_mvl401-8272ads (root@em178110) (gcc version 3.4.3
(MontaVi7
Motorola PQ2 ADS PowerPC port
Built 1 zonelists
Kernel command line: root=/dev/ram
PID hash table entries: 512 (order: 9, 8192 bytes)
hr_time_init: arch_to_nsec = 83886080, nsec_to_arch = 107374182
Warning: real time clock seems stuck!
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 59888k available (1684k kernel code, 468k data, 88k init, 0k
highmem)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
spawn_desched_task(00000000)
desched cpu_callback 3/00000000
ksoftirqd started up.
desched cpu_callback 2/00000000
checking if image is initramfs...desched thread 0 started up.
it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 2694k freed
NET: Registered protocol family 16
mpc8272ads: Init
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
Serial: CPM driver $Revision: 0.01 $
ttyCPM0 at MMIO 0xf0011a00 (irq = 40) is a CPM UART
ttyCPM1 at MMIO 0xf0011a60 (irq = 43) is a CPM UART
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
fs_enet.c:v1.0 (Aug 8, 2005)
fs_enet: eth0 Phy @ 0x0, type DM9161 (0x0181b881)
fs_enet: eth1 Phy @ 0x3, type DM9161 (0x0181b881)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
eth2: FCC ENET Version 0.3, 00:99:23:c4:ad:de
eth3: FCC ENET Version 0.3, 00:99:23:44:ad:de
eth4: FCC ENET Version 0.3, 00:99:23:64:ad:de
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
NET: Registered protocol family 1
NET: Registered protocol family 17
RAMDISK: Compressed image found at block 0
RAMDISK: incomplete write (-28 != 32768) 8388608
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(1,0)
 <0>Rebooting in 180 seconds..

what may be the problem?
I have root file system then..can i create fresh ramdisk image..if yes then
how to create it?


-- 
View this message in context: http://www.nabble.com/linux-booting-using-ramdisk-tf3062233.html#a8515241
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
