Return-Path: <hbausley@deltatau.com>
Received: from mail.deltatau.com (smtp.deltatau.com [64.60.44.211])
	by ozlabs.org (Postfix) with ESMTP id 8CB21DDE23
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Nov 2008 11:54:49 +1100 (EST)
Subject: AMCC 460EX SATA drive on Canyonlands
From: Henry Bausley <hbausley@deltatau.com>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <4921BA09.1030508@freescale.com>
References: <DF6C7BC3780EE44B83430A9F756D43B608581D77@SJEXCH03.ds.jdsu.net>
	<4921A2EE.6050201@freescale.com>
	<DF6C7BC3780EE44B83430A9F756D43B60858239D@SJEXCH03.ds.jdsu.net>
	<4921BA09.1030508@freescale.com>
Content-Type: text/plain
Date: Mon, 17 Nov 2008 16:54:05 -0800
Message-Id: <1226969645.808.13.camel@lt-linuxhenry>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I can't seem to see a SATA drive on my 460EX Canyonlands board.  Did I
miss something in the kernel configuration.  The drive is a Seagate
Baracuda  750M - ST3750330AS


Below are the messages I get:

sata-dwc sata-dwc.0: id 0, controller version 1.82
sata-dwc sata-dwc.0: DMA initialized
sata-dwc sata-dwc.0: **** No negotiated speed (nothing attached?) ****
scsi0 : sata-dwc
ata1: SATA max UDMA/133 irq 21
4cc000000.nor_flash: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
4cc000000.nor_flash: CFI does not contain boot bank location. Assuming
top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
RedBoot partition parsing not available
Creating 7 MTD partitions on "4cc000000.nor_flash":
0x00000000-0x001e0000 : "kernel"
0x001e0000-0x00200000 : "dtb"
0x00200000-0x01600000 : "ramdisk"
0x01600000-0x01a00000 : "jffs2"
0x01a00000-0x03f60000 : "user"
0x03f60000-0x03fa0000 : "env"
0x03fa0000-0x04000000 : "u-boot"
ppc-of-ehci 4bffd0400.ehci: OF EHCI
ppc-of-ehci 4bffd0400.ehci: new USB bus registered, assigned bus number
1
ppc-of-ehci 4bffd0400.ehci: irq 33, io mem 0x4bffd0400
ppc-of-ehci 4bffd0400.ehci: USB 2.0 started, EHCI 1.00, driver 10 Dec
2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
Initializing USB Mass Storage driver...
usb 1-1: new high speed USB device using ppc-of-ehci and address 2
usb 1-1: configuration #1 chosen from 1 choice
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 2 ports detected
usb 1-1.1: new high speed USB device using ppc-of-ehci and address 3
usb 1-1.1: configuration #1 chosen from 1 choice
scsi1 : SCSI emulation for USB Mass Storage devices
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
