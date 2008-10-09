Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 8714BDE6C0
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 05:05:08 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Knzsl-0005Pb-Lo
	for linuxppc-dev@ozlabs.org; Thu, 09 Oct 2008 11:05:03 -0700
Message-ID: <19904213.post@talk.nabble.com>
Date: Thu, 9 Oct 2008 11:05:03 -0700 (PDT)
From: Jeff Borlin <jborlin@aclaratech.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Compact Flash on 8349mITX
In-Reply-To: <ed82fe3e0810091028hfd74437s18c538cedd0163a2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <6011A7C9CD0EE74792C3ED2A83556086342189@mail.twacs.com>
	<6011A7C9CD0EE74792C3ED2A8355608634218F@mail.twacs.com>
	<19900326.post@talk.nabble.com>
	<ed82fe3e0810090928v7d50a56ei67ee2c5477491fe7@mail.gmail.com>
	<19903135.post@talk.nabble.com>
	<ed82fe3e0810091028hfd74437s18c538cedd0163a2@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The version on the CD does not seem to see it at all:  
[...]
U-Boot 1.3.4-rc1-00012-g1953d12 (Jul 28 2008 - 09:09:09) MPC83XX
[...]
Linux version 2.6.13.4 (ljd015@dragon.am.freescale.net) (gcc version 3.4.3)
#1 Thu Oct 19 16:27:15 EDT 2006
PCI2 confirm: isa_io_base = 0xfc000000
Configure PCI2 controller isa_io_base = 0xfc000000
hose2->io_base_virt = 0xfd000000
Built 1 zonelists
Kernel command line: root=/dev/ram ramdisk_size=65000 rw
ip=10.100.17.83:10.100.10.74:10.100.17.1:255.255.255.0::eth0:off
console=ttyS0,115200 mtdparts=physmap-flash.0:64k,8128k,-
IPIC (128 IRQ sources, 8 External IRQs) at fe000700
PID hash table entries: 2048 (order: 11, 32768 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 244096k available (2432k kernel code, 884k data, 120k init, 0k
highmem)
Mount-cache hash table entries: 512
checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd
Freeing initrd memory: 11910k freed
NET: Registered protocol family 16
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 0 of device 0000:00:00.0
PCI: Cannot allocate resource region 2 of device 0000:00:00.0
PCI: Cannot allocate resource region 0 of device 0001:01:00.0
PCI: Cannot allocate resource region 2 of device 0001:01:00.0
PCI: Failed to allocate mem resource #2:80000000@0 for 0000:00:00.0
PCI: Failed to allocate mem resource #2:80000000@0 for 0001:01:00.0
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
NTFS driver 2.1.23 [Flags: R/W DEBUG].
Generic RTC Driver v1.07
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at MMIO 0xe0004500 (irq = 9) is a 16550A
ttyS1 at MMIO 0xe0004600 (irq = 10) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 65000K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 6.0.60-k2
Copyright (c) 1999-2005 Intel Corporation.
eth0: Gianfar Ethernet Controller Version 1.1, 08:00:3e:03:01:10
eth0: Running with NAPI enabled
eth0: 32/32 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.1, 08:00:3e:03:01:11
eth1: Running with NAPI enabled
eth1: 32/32 RX/TX BD ring size
sata_sil(0000:00:10.0): cache line size not set.  Driver may not function
ata1: SATA max UDMA/100 cmd 0xD1000C80 ctl 0xD1000C8A bmdma 0xD1000C00 irq
22
ata2: SATA max UDMA/100 cmd 0xD1000CC0 ctl 0xD1000CCA bmdma 0xD1000C08 irq
22
ata3: SATA max UDMA/100 cmd 0xD1000E80 ctl 0xD1000E8A bmdma 0xD1000E00 irq
22
ata4: SATA max UDMA/100 cmd 0xD1000EC0 ctl 0xD1000ECA bmdma 0xD1000E08 irq
22
ata1: no device found (phy stat 00000000)
scsi0 : sata_sil
ata2: no device found (phy stat 00000000)
scsi1 : sata_sil
ata3: no device found (phy stat 00000000)
scsi2 : sata_sil
ata4: no device found (phy stat 00000000)
scsi3 : sata_sil
usbmon: debugfs is not available
driver fsl-usb2-mph, $Revision: 1.11 $
[...]

Will try Anton's suggestions next.  

-Jeff

Timur Tabi-3 wrote:
> 
> On Thu, Oct 9, 2008 at 12:00 PM, Jeff Borlin <jborlin@aclaratech.com>
> wrote:
>>
>> Can you point me to where that can be found?
> 
> It's on the CD that came with the board.
> 
> -- 
> Timur Tabi
> Linux kernel developer at Freescale
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 

-- 
View this message in context: http://www.nabble.com/Compact-Flash-on-8349mITX-tp18754330p19904213.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
