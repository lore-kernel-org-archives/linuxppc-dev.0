Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 7581EDDDF3
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jul 2007 03:05:30 +1000 (EST)
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 834BF206CA1
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 19:10:08 +0200 (CEST)
Received: from ibook.aepfle.de (DSL01.83.171.147.52.ip-pool.NEFkom.net
	[83.171.147.52])
	by mail.mnet-online.de (Postfix) with ESMTP id 81994905F8
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 19:05:28 +0200 (CEST)
Date: Fri, 13 Jul 2007 19:05:40 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org
Subject: hvc_iseries not working
Message-ID: <20070713170540.GA1987@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


2.6.21 arch/powerpc/configs/iseries_defconfig works on an i825 with v5r4
2.6.22 arch/powerpc/configs/iseries_defconfig does not. But it works on
a i820 with v5r3.
2.6.22 boots ok with CONFIG_VIOCONS

It gets up to this point:

vio_bus_init: processing c0000000fbfff570
vio_bus_init: processing c0000000fbfff6b0
vio_bus_init: processing c0000000fbfff7f0
vio_bus_init: processing c0000000fbfff930
vio_bus_init: processing c0000000fbfffa70
vio_bus_init: processing c0000000fbfffbb0
audit: initializing netlink socket (disabled)
audit(1184327881.720:1): initialized
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
viopath: opening connection to partition 0, setting sinst 32778, tinst 32769
hvc: hosting partition 0
vio_register_driver: driver hvc_console registering
Generic RTC Driver v1.07
RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blo


with ppc64_defconfig it looks like that:


audit: initializing netlink socket (disabled)
audit(1184326841.030:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
rpaphp: RPA HOT Plug PCI Controller Driver version: 0.1
rpadlpar_io_init: partition not DLPAR capable
HVSI: registered 0 devices
viopath: opening connection to partition 0, setting sinst 32774, tinst 32769
hvc: hosting partition 0
vio_register_driver: driver hvc_console registering
Generic RTC Driver v1.07
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing
