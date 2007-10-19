Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3EA5ADDE45
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Oct 2007 19:03:39 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IinlX-0001uy-8o
	for linuxppc-embedded@ozlabs.org; Fri, 19 Oct 2007 02:03:35 -0700
Message-ID: <13290652.post@talk.nabble.com>
Date: Fri, 19 Oct 2007 02:03:35 -0700 (PDT)
From: aauer1 <aauer1@gmx.at>
To: linuxppc-embedded@ozlabs.org
Subject: SystemACE driver problem
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


Hello

I'm trying to boot a Linux Kernel 2.6.23-rc2 from Grant Likely (thanks for
the great work) on a Xilinx ML403 board. I want to use the second partition
of the Compact Flash Card as root filesystem. But the boot process hangs at
the initialization of the SystemACE module. A strange effect is that the
DONE LED (configuration of the FPGA is done) turns off. So, this means that
the FPGA loses his configuration.
Has anybody recognized a similar problem with the SystemACE module??

The boot log:
========
[    0.000000] Linux version 2.6.23-rc2 (bbauer@soclin) (gcc version 4.0.0
(DEN7
[    0.000000] Xilinx ML403 Reference System (Virtex-4 FX)
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->    16384
[    0.000000]   Normal      16384 ->    16384
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->    16384
[    0.000000] Built 1 zonelists in Zone order.  Total pages: 16256
[    0.000000] Kernel command line: console=ttyUL0 root=/dev/xsa2 rw
[    0.000000] Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFF000
[    0.000000] PID hash table entries: 256 (order: 8, 1024 bytes)
[    0.000328] Console: colour dummy device 80x25
[    0.001390] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.002934] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.029759] Memory: 63244k available (1176k kernel code, 388k data, 84k
init)
[    0.120774] Mount-cache hash table entries: 512
[    0.171986] io scheduler noop registered
[    0.172248] io scheduler anticipatory registered (default)
[    0.172300] io scheduler deadline registered
[    0.172508] io scheduler cfq registered
[    0.268807] uartlite.0: ttyUL0 at MMIO 0x40600000 (irq = 2) is a uartlite
[    0.270399] console [ttyUL0] enabled
[    1.762725] RAMDISK driver initialized: 8 RAM disks of 8192K size 1024
blocke
[    1.852062] Registering Xilinx SystemACE driver, major=254
[    1.919734] xsysace xsysace.0: ace_probe(c01638e0)


Thanks,
Andreas
-- 
View this message in context: http://www.nabble.com/SystemACE-driver-problem-tf4651846.html#a13290652
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
