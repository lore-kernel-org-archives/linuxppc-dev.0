Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 280C4DDE3B
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 18:51:51 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Izp2r-0001hA-2M
	for linuxppc-dev@ozlabs.org; Tue, 04 Dec 2007 23:51:49 -0800
Message-ID: <14166848.post@talk.nabble.com>
Date: Tue, 4 Dec 2007 23:51:49 -0800 (PST)
From: sivaji <rameshmrm@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Regarding MPC8641D
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hai,
            We have designed  a MPC8641D based AMC card. We are using the
kernel (2.6.23-rc4) and uboot (1.2.0).  When we disable the core1 Low Memory
offset mode the kernel was up and when we enable this core1 Low Memory
offset mode kernel was not up, It was hang after MPIC initialization.

Kerenl dump :          

# Booting image at 00200000 ...
  Image Name:   Linux-2.6.23-rc4-g5326152f-dirty
  Image Type:   PowerPC Linux Kernel Image (gzip compressed)
  Data Size:    4544816 Bytes =  4.3 MB
  Load Address: 00000000
  Entry Point:  00000000
  Verifying Checksum ... OK
  Uncompressing Kernel Image ... OK
  Booting using flat device tree at 0x700000
data:0
Probing machine type ...
 MPC86xx HPCN ...start c05d1e10 end c05d1ee0 <6>Using MPC86xx HPCN machine
description
Total memory = 600MB; using 2048kB for hash table (at cfe00000)
Linux version 2.6.23-rc4-g5326152f-dirty (root@sivaji) (gcc version 4.0.2
20060628 (Wasabi)) #45 SMP Wed Dec 5 12:01:58 IST 2007
console [udbg0] enabled
setup_arch: bootmem
mpc86xx_hpcn_setup_arch()
Found FSL PCI host bridge at 0x00000000f8008000.Firmware bus number: 0->254
MPC86xx HPCN board from Freescale Semiconductor
arch: exit
Zone PFN ranges:
 DMA             0 ->   153600
 Normal     153600 ->   153600
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
   0:        0 ->   153600
Built 1 zonelists in Zone order.  Total pages: 152400
Kernel command line: root=/dev/ram console=ttyS0,115200 mem=600M
mpic: Setting up MPIC " MPIC     " version 1.2 at f8040000, max 2 CPUs
mpic: ISU size: 88, shift: 7, mask: 7f
mpic: Initializing for 88 sources
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 600064k/614400k available (5832k kernel code, 14096k reserved, 116k
data, 233k bss, 3244k init)
SLUB: Genslabs=22, HWalign=32, Order=0-1, MinObjects=4, CPUs=2, Nodes=1
Security Framework v1.0.0 initialized
SELinux:  Initializing.
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
mpic: requesting IPIs ...

                     After this the kernel was hang, i want to know why
kernel was hang when we enalbe Low memory Offset mode. Please help me to fix
this issue.
Thanks and Regards
Sivaji
-- 
View this message in context: http://www.nabble.com/Regarding-MPC8641D-tf4948004.html#a14166848
Sent from the linuxppc-dev mailing list archive at Nabble.com.
