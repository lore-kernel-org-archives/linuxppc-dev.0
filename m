Return-Path: <surendranath.moilla@cmcltd.com>
Received: from omr.securemx.in (omr.securemx.in [121.241.247.18])
	by ozlabs.org (Postfix) with ESMTP id 01DCDDDF97
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 05:59:44 +1000 (EST)
Received: from oedge102-rme.smx.co.in ([10.41.20.27])
	by omta102-rme.smx.co.in with ESMTP id
	<20080818195941.QTGC2647.omta102-rme.smx.co.in@oedge102-rme.smx.co.in>
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Aug 2008 19:59:41 +0000
Received: from cmcdak.cmcltd.com ([59.160.161.9]) by oedge102-rme.smx.co.in
	with ESMTP
	id <20080818195940.EIKI23969.oedge102-rme.smx.co.in@cmcdak.cmcltd.com>
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Aug 2008 19:59:40 +0000
Received: from webmail.cmcltd.com (newwebmail [172.16.3.3])
	by cmcdak.cmcltd.com (8.13.1/8.13.1) with ESMTP id m7IJomkE011691
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 01:20:48 +0530
Message-ID: <60403.136.182.158.145.1219088591.squirrel@webmail.cmcltd.com>
In-Reply-To: <20080818155921.GA26475@loki.buserror.net>
References: <380-220088118115212377@M2W006.mail2web.com>
	<20080818155921.GA26475@loki.buserror.net>
Date: Tue, 19 Aug 2008 01:13:11 +0530 (IST)
Subject: Re: Clock / Timebase / Bus Frequencies Help
From: surendranath.moilla@cmcltd.com
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

  I have a similar problem with custom MPC8360 board.
I am able to boot Linux with the mpc836x_dts.dtb provided by freescale.
but when use dtb customised for my  board i am unable to boot Linux.
It is hanging after the console handover to real console from boot console.

I am filling all the frequencies properly, can someone help me to fix this
Where to set the baud rate in dts file.

Here is the log:


=> tftp $loadaddr /nfk684/vpm_test/uImage
Using FSL UEC0 device
TFTP from server 192.168.0.2; our IP address is 192.168.0.100
Filename '/nfk684/vpm_test/uImage'.
Load address: 0x200000
Loading: #################################################################
         ##########
done
Bytes transferred = 1095689 (10b809 hex)
=> tftp $fdtaddr /nfk684/vpm_test/mpc8360_vpm.dtb
Using FSL UEC0 device
TFTP from server 192.168.0.2; our IP address is 192.168.0.100
Filename '/nfk684/vpm_test/mpc8360_vpm.dtb'.
Load address: 0x400000
Loading: #
done
Bytes transferred = 12288 (3000 hex)
=> bootm $loadaddr - $fdtaddr
## Booting image at 00200000 ...
   Image Name:   Linux-2.6.22
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1095625 Bytes =  1 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Booting using the fdt at 0x400000
 Probing machine type
Using MPC8360 VPM machine description
Linux version 2.6.22 (nfk684@ilec4411) (gcc version 4.0.0 (DENX ELDK 4.1
4.0.0))
 #17 Fri Aug 15 16:13:41 CDT 2008
setup_arch: bootmem
mpc8360_vpm_setup_arch()
Bad clock source for time stamp 1
Bad clock source for time stamp 2
arch: exit
Zone PFN ranges:
  DMA             0 ->    65536
  Normal      65536 ->    65536
early_node_map[1] active PFN ranges
    0:        0 ->    65536
Built 1 zonelists.  Total pages: 65024
Kernel command line: root=/dev/ram rw console=ttyS1,115200
IPIC (128 IRQ sources) at fdefc700
QEIC (64 IRQ sources) at fdefb080
PID hash table entries: 1024 (order: 10, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 257280k/262144k available (2152k kernel code, 4624k reserved, 96k
data,
80k bss, 128k init)
Mount-cache hash table entries: 512
NET: Registered protocol family 16

Generic PHY: Registered new driver
SCSI subsystem initialized
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
JFFS2 version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Generic RTC Driver v1.07
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 16) is a 16550A
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 17) is a 16550A
console handover: boot [udbg0] -> real [ttyS1]

Regards
Surendra


> On Mon, Aug 18, 2008 at 07:52:12AM -0400, richw@netcomuk.co.uk wrote:
>> We've got an 8347 based board very similar to the A&M asp8347. Core
>> clock
>> is 400MHz. Bus clock is 266666666Hz.
>> According to the data sheet for the 8347, the decrementer clock runs at
>> a
>> quarter of the rate of the bus clock. I have two questions:
>> In arch/powerpc/boot/redboot-83xx.c, the timebase clock is passed to
>> dt_fixup_cpu_clocks() as bi_busfreq / 16. If I leave it like this, my
>> system clock runs approximately 4 times too fast.
>> Can anyone point me in the direction of an explanation for the div by 16
>> rather than 4?
>
> It's a bug, which I pointed out here:
> http://ozlabs.org/pipermail/linuxppc-dev/2008-June/058704.html
>
>> If I change the call to dt_fixup_cpu_clocks so that bi_busfreq/4 is
>> passed
>> in, then the clock runs more accurately. However, its still not correct.
>> This gives a decrementer frequency of 66666666Hz, but if I hard code the
>> value to 66000000Hz, the clock runs accurately.
>> Can anyone shed any light on why the value passed in by the boot loader
>> (redboot) seems to be inaccurate.
>
> Redboot probably has the wrong crystal frequency hardcoded.
>
> -Scott
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
