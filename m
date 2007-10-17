Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EE304DDE2C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Oct 2007 04:12:36 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IiDNh-0004cG-Pd
	for linuxppc-embedded@ozlabs.org; Wed, 17 Oct 2007 11:12:33 -0700
Message-ID: <13259685.post@talk.nabble.com>
Date: Wed, 17 Oct 2007 11:12:33 -0700 (PDT)
From: aauer1 <aauer1@gmx.at>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Linux booting problem on Xilinx ppc
In-Reply-To: <fa686aa40710170754p54aa405au9b046f7039ecb9ac@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <12694083.post@talk.nabble.com>
	<fa686aa40709152009k2b27ffc9kfb3fd0848f6b16d@mail.gmail.com>
	<12696686.post@talk.nabble.com> <13219154.post@talk.nabble.com>
	<000901c81006$7303b490$bb3ca688@LGE.NET>
	<13239003.post@talk.nabble.com>
	<fa686aa40710161237t54688b71g9c7cf9acdac2b744@mail.gmail.com>
	<13252272.post@talk.nabble.com>
	<fa686aa40710170754p54aa405au9b046f7039ecb9ac@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Grant Likely-2 wrote:
> 
> On 10/17/07, aauer1 <aauer1@gmx.at> wrote:
>> Now, I know that the kernel boots but I don't get an output with my
>> Xilinx
>> UartLite module. Are there some kernel modules which must be activated??
>> Btw. I have used the Linux-2.6-virtex kernel from
>> http://git.secretlab.ca/git/ and another Kernel (2.6.23 from kernel.org)
>> -
>> both with the same result.
> 
> Post the output of __log_buf here please.
> 
> 

Here is my dump of the __log_buf:
======================
<5>[    0.000000] Linux version 2.6.23-rc2
(aauer@servitus.student.iaik.tugraz.at) (gcc version 4.0.0 (DENX ELDK 4.1
4.0
.0)) #8 Wed Oct 17 20:05:28 CEST 2007
<6>[    0.000000] Xilinx ML403 Reference System (Virtex-4 FX)
<7>[    0.000000] Entering add_active_range(0, 0, 16384) 0 entries of 256
used
<4>[    0.000000] Zone PFN ranges:
<4>[    0.000000]   DMA             0 ->    16384
<4>[    0.000000]   Normal      16384 ->    16384
<4>[    0.000000] Movable zone start PFN for each node
<4>[    0.000000] early_node_map[1] active PFN ranges
<4>[    0.000000]     0:        0 ->    16384
<7>[    0.000000] On node 0 totalpages: 16384
<7>[    0.000000]   DMA zone: 128 pages used for memmap
<7>[    0.000000]   DMA zone: 0 pages reserved
<7>[    0.000000]   DMA zone: 16256 pages, LIFO batch:3
<7>[    0.000000]   Normal zone: 0 pages used for memmap
<7>[    0.000000]   Movable zone: 0 pages used for memmap
<4>[    0.000000] Built 1 zonelists in Zone order.  Total pages: 16256
<5>[    0.000000] Kernel command line: console=ttUL0 root=/dev/xsysace2 rw
<6>[    0.000000] Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFF000
<4>[    0.000000] PID hash table entries: 256 (order: 8, 1024 bytes)
<4>[    0.000325] Console: colour dummy device 80x25
<6>[    0.001380] Dentry cache hash table entries: 8192 (order: 3, 32768
bytes)
<6>[    0.002924] Inode-cache hash table entries: 4096 (order: 2, 16384
bytes)
<4>[    0.029750] Memory: 63256k available (1172k kernel code, 384k data,
84k init, 0k highmem)
<7>[    0.030975] Calibrating delay loop... 299.00 BogoMIPS (lpj=598016)
<4>[    0.120718] Mount-cache hash table entries: 512
<6>[    0.171779] io scheduler noop registered
<6>[    0.171857] io scheduler anticipatory registered (default)
<6>[    0.171884] io scheduler deadline registered
<6>[    0.172262] io scheduler cfq registered
<6>[    0.268268] uartlite.0: ttyUL0 at MMIO 0x40600000 (irq = 2) is a
uartlite
<4>[    0.281400] RAMDISK driver initialized: 8 RAM disks of 8192K size 1024
blocksize
<6>[    0.282765] mice: PS/2 mouse device common for all mice
<4>[    0.286181] VFS: Cannot open root device "xsysace2" or
unknown-block(0,0)
<4>[    0.286252] Please append a correct "root=" boot option; here are the
available partitions:
<0>[    0.286323] Kernel panic - not syncing: VFS: Unable to mount root fs
on unknown-block(0,0)
<0>[    0.286374] Rebooting in 180 seconds..

Thanks,
Andreas

-- 
View this message in context: http://www.nabble.com/Linux-booting-problem-on-Xilinx-ppc-tf4449060.html#a13259685
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
