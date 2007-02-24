Return-Path: <bounces@nabble.com>
Received: from talk.nabble.com (www.nabble.com [72.21.53.35])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CF35BDDEAB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Feb 2007 19:38:35 +1100 (EST)
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50) id 1HKsQK-0001tj-Ot
	for linuxppc-embedded@ozlabs.org; Sat, 24 Feb 2007 00:38:32 -0800
Message-ID: <9132046.post@talk.nabble.com>
Date: Sat, 24 Feb 2007 00:38:32 -0800 (PST)
From: Nethra <nethra_gmit@yahoo.co.in>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] jffs2 file system
In-Reply-To: <1172144688.2759.0.camel@vader.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <9097247.post@talk.nabble.com>
	<1172144688.2759.0.camel@vader.jdub.homelinux.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>




steps falloed are..

1. erase FF800000 FFDFFFFF
2. tftpboot 0x100000 image.jffs2 
3. cp.b 100000 FF800000 4dc874


> printenv
bootdelay=5
baudrate=38400
ethact=FCC2 ETHERNET
ethaddr=00:99:23:44:ad:de
filesize=4dc874
fileaddr=100000
ipaddr=192.168.178.83
serverip=192.168.178.110
bootcmd=tftpboot 0x1000000 jffsenabled;bootm 0x1000000;
stdin=serial
stdout=serial
stderr=serial
bootargs=root=/dev/mtdblock0 rootfstype=jffs2

Environment size: 296/262140 bytes

output of boot messages....
=> run bootcmd
Using FCC2 ETHERNET device
TFTP from server 192.168.178.110; our IP address is 192.168.178.83
Filename 'jffsenabled'.
Load address: 0x1000000
Loading: #################################################################
         #################################################################
         #################################################################
         ########
done
Bytes transferred = 1036518 (fd0e6 hex)
## Booting image at 01000000 ...
   Image Name:   Linux-2.6.10_mvl401-8272ads
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1036454 Bytes = 1012.2 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.6.10_mvl401-8272ads (root@em178110) (gcc version 3.4.3
(MontaVis
ta 3.4.3-25.0.70.0501961 2005-12-18)) #11 Thu Feb 15 11:40:04 IST 2007
Motorola PQ2 ADS PowerPC port
Built 1 zonelists
Kernel command line: root=/dev/mtdblock0 rootfstype=jffs2
PID hash table entries: 256 (order: 8, 4096 bytes)
hr_time_init: arch_to_nsec = 83886080, nsec_to_arch = 107374182
Warning: real time clock seems stuck!
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 29952k available (1856k kernel code, 512k data, 92k init, 0k
highmem)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
spawn_desched_task(00000000)
desched cpu_callback 3/00000000
ksoftirqd started up.
desched cpu_callback 2/00000000
desched thread 0 started up.
NET: Registered protocol family 16
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
Initializing Cryptographic API
Serial: CPM driver $Revision: 0.01 $
ttyCPM0 at MMIO 0xf0011a00 (irq = 40) is a CPM UART
ttyCPM1 at MMIO 0xf0011a60 (irq = 43) is a CPM UART
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
loop: loaded (max 8 devices)
fs_enet.c:v1.0 (Aug 8, 2005)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
elevator: using anticipatory as default io scheduler
$Id: ftl.c,v 1.55 2005/01/17 13:47:21 hvr Exp $
physmap flash device: 800000 at ff800000
RedBoot partition parsing not available
Using physmap partition definition
Creating 4 MTD partitions on "phys_mapped_flash":
0x00000000-0x00600000 : "User FS"
mtd: Giving out device 0 to User FS
ftl_cs: FTL header not found.
0x00600000-0x00700000 : "uImage"
mtd: Giving out device 1 to uImage
ftl_cs: FTL header not found.
0x00700000-0x00740000 : "bootloader"
mtd: Giving out device 2 to bootloader
ftl_cs: FTL header not found.
0x00740000-0x00780000 : "bootloader env"
mtd: Giving out device 3 to bootloader env
ftl_cs: FTL header not found.
eth0: FCC ENET Version 0.3, 00:99:23:c4:ad:de
eth1: FCC ENET Version 0.3, 00:99:23:44:ad:de
eth2: FCC ENET Version 0.3, 00:99:23:64:ad:de
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
NET: Registered protocol family 1
NET: Registered protocol family 17
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000000:
0xffff in
....
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x005c0004:
0xffff in 

and it display rebooting in 180 seconds

what is the problem?

Nethra


Josh Boyer-2 wrote:
> 
> On Thu, 2007-02-22 at 02:16 -0800, Nethra wrote:
>> 
>> hi,
>>  I m using PQ2FADS-ZU board and montavista kernel 2.6.10.
>> u-boot is u-boot-1.1.1
>> 
>> Kernel configuration for MTD and JFFS2 support...
> 
> Posting the output of your boot messages will likely get you more help
> than a .config.
> 
> josh
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/jffs2-file-system-tf3271928.html#a9132046
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
