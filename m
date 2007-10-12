Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F3FE0DDDE9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Oct 2007 19:13:20 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IgGa5-0003b7-H1
	for linuxppc-embedded@ozlabs.org; Fri, 12 Oct 2007 02:13:17 -0700
Message-ID: <13171747.post@talk.nabble.com>
Date: Fri, 12 Oct 2007 02:13:17 -0700 (PDT)
From: Abhijit Naik <abhijit_naik27@rediffmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: nfs mounting problem
In-Reply-To: <OF08754E94.1194DC2D-ON6525726C.0043EADB-6525726C.0044D6F4@lntemsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <OF08754E94.1194DC2D-ON6525726C.0043EADB-6525726C.0044D6F4@lntemsys.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello Manjunath,
      You open the ports of portmaper and nfs from firewall. Refer
http://www.linuxquestions.org/questions/linux-security-4/firewall-blocking-nfs-even-though-ports-are-open-294069/.
Hope you get your problem solved.
     
All teh best


Manjunath AM wrote:
> 
> Hi,
> 
> We are using MPC8272 based target board, we are trying to mount montavista 
> Linux version 2.6.10 kernel image (with NFS enabled) to our target board,
> we are setting following bootargs in bootloader 
> 
> "setenv bootargs root=/dev/nfs 
> nfsroot=192.168.178.110:/opt/montavista/pro/devkit/ppc/82xx/target 
> ip=192.168.178.234:192.168.178.110:192.168.178.47:255.255.255.0:cashel:eth1:off"
> 
> when we boot the board, it is not able to mount nfs file system to board, 
> but the same image and configuration works with MPC8272ADS board.
> please suggest me, what could be the problem.
> 
> Booting image at 00200000 ...
>    Image Name:   Linux-2.6.10_mvl401-8272ads
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    948607 Bytes = 926.4 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> Linux version 2.6.10_mvl401-8272ads (root@em178110) (gcc version 3.4.3 
> (MontaVista 3.4.3-25.0.70.050
> 1961 2005-12-18)) #2 Tue Jan 23 16:54:50 IST 2007
> Motorola PQ2 ADS PowerPC port
> Built 1 zonelists
> Kernel command line: root=/dev/nfs 
> nfsroot=192.168.178.110:/opt/montavista/pro/devkit/ppc/82xx/targe
> t 
> ip=192.168.178.234:192.168.178.110:192.168.178.47:255.255.255.0:cashel:eth1:off
> PID hash table entries: 128 (order: 7, 2048 bytes)
> hr_time_init: arch_to_nsec = 83886080, nsec_to_arch = 107374182
> Warning: real time clock seems stuck!
> Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
> Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
> Memory: 13952k available (1684k kernel code, 468k data, 100k init, 0k 
> highmem)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> spawn_desched_task(00000000)
> desched cpu_callback 3/00000000
> ksoftirqd started up.
> desched cpu_callback 2/00000000
> desched thread 0 started up.
> NET: Registered protocol family 16
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> Initializing Cryptographic API
> Serial: CPM driver $Revision: 0.01 $
> ttyCPM0 at MMIO 0xf0011a00 (irq = 40) is a CPM UART
> ttyCPM1 at MMIO 0xf0011a60 (irq = 43) is a CPM UART
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered
> RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
> loop: loaded (max 8 devices)
> fs_enet.c:v1.0 (Aug 8, 2005)
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 50MHz system bus speed for PIO modes; override with 
> idebus=xx
> eth0: FCC ENET Version 0.3, 00:99:23:c4:ad:de
> eth1: FCC ENET Version 0.3, 00:99:23:44:ad:de
> eth2: FCC ENET Version 0.3, 00:99:23:64:ad:de
> NET: Registered protocol family 2
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 1024 bind 2048)
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> IP-Config: Complete:
>       device=eth1, addr=192.168.178.234, mask=255.255.255.0, 
> gw=192.168.178.47,
>      host=cashel, domain=, nis-domain=(none),
>      bootserver=192.168.178.110, rootserver=192.168.178.110, rootpath=
> Looking up port of RPC 100003/2 on 192.168.178.110
> portmap: server 192.168.178.110 not responding, timed out
> Root-NFS: Unable to get nfsd port number from server, using default
> Looking up port of RPC 100005/1 on 192.168.178.110
> portmap: server 192.168.178.110 not responding, timed out
> Root-NFS: Unable to get mountd port number from server, using default
> mount: server 192.168.178.110 not responding, timed out
> Root-NFS: Server returned error -5 while mounting 
> /opt/montavista/pro/devkit/ppc/82xx/target
> VFS: Unable to mount root fs via NFS, trying floppy.
> VFS: Cannot open root device "nfs" or unknown-block(2,0)
> Please append a correct "root=" boot option
> Kernel panic - not syncing: VFS: Unable to mount root fs on 
> unknown-block(2,0)
>  <0>Rebooting in 180 seconds..
> 
> Thanks and awaiting for your valuable feedback
> 
> 
> 
> Thanks & Regards
>  MANJUNATH AM
>  
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
:-)
-- 
View this message in context: http://www.nabble.com/nfs-mounting-problem-tf3063819.html#a13171747
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
