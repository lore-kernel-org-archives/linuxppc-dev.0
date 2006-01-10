Return-Path: <gregkh@suse.de>
Received: from perch.kroah.org (mail.kroah.org [69.55.234.183])
	by ozlabs.org (Postfix) with ESMTP id B05176898F
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jan 2006 17:02:00 +1100 (EST)
To: rmk@arm.linux.org.uk, greg@kroah.com, gregkh@suse.de,
	linuxppc-dev@ozlabs.org, rmk+kernel@arm.linux.org.uk
From: <gregkh@suse.de>
Date: Mon, 09 Jan 2006 22:00:04 -0800
In-Reply-To: <20060105142951.13.19@flint.arm.linux.org.uk>
Message-ID: <1EwCY8-1zu-00@press.kroah.org>
Subject: patch add-macio_bus_type-probe-and-remove-methods.patch added to
	gregkh-2.6 tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This is a note to let you know that I've just added the patch titled

     Subject: [CFT 19/29] Add macio_bus_type probe and remove methods

to my gregkh-2.6 tree.  Its filename is

     add-macio_bus_type-probe-and-remove-methods.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From rmk+greg=kroah.com@arm.linux.org.uk Thu Jan  5 06:42:59 2006
From: Russell King <rmk@arm.linux.org.uk>
CC: Greg K-H <greg@kroah.com>, MAC <linuxppc-dev@ozlabs.org>
Subject: [CFT 19/29] Add macio_bus_type probe and remove methods
Date: Thu, 05 Jan 2006 14:39:24 +0000
Message-ID: <20060105142951.13.19@flint.arm.linux.org.uk>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/macintosh/macio_asic.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- gregkh-2.6.orig/drivers/macintosh/macio_asic.c
+++ gregkh-2.6/drivers/macintosh/macio_asic.c
@@ -204,6 +204,9 @@ struct bus_type macio_bus_type = {
        .name	= "macio",
        .match	= macio_bus_match,
        .uevent = macio_uevent,
+       .probe	= macio_device_probe,
+       .remove	= macio_device_remove,
+       .shutdown = macio_device_shutdown,
        .suspend	= macio_device_suspend,
        .resume	= macio_device_resume,
        .dev_attrs = macio_dev_attrs,
@@ -487,9 +490,6 @@ int macio_register_driver(struct macio_d
 	/* initialize common driver fields */
 	drv->driver.name = drv->name;
 	drv->driver.bus = &macio_bus_type;
-	drv->driver.probe = macio_device_probe;
-	drv->driver.remove = macio_device_remove;
-	drv->driver.shutdown = macio_device_shutdown;
 
 	/* register with core */
 	count = driver_register(&drv->driver);


Patches currently in gregkh-2.6 which might be from rmk@arm.linux.org.uk are

driver/add-bttv-sub-bus_type-probe-and-remove-methods.patch
driver/add-bus_type-probe-remove-shutdown-methods..patch
driver/add-ccwgroup_bus_type-probe-and-remove-methods.patch
driver/add-dio_bus_type-probe-and-remove-methods.patch
driver/add-ecard_bus_type-probe-remove-shutdown-methods.patch
driver/add-gameport-bus_type-probe-and-remove-methods.patch
driver/add-i2c_bus_type-probe-and-remove-methods.patch
driver/add-ide_bus_type-probe-and-remove-methods.patch
driver/add-locomo-bus_type-probe-remove-methods.patch
driver/add-logic-module-bus_type-probe-remove-methods.patch
driver/add-macio_bus_type-probe-and-remove-methods.patch
driver/add-mcp-bus_type-probe-and-remove-methods.patch
driver/add-mmc_bus_type-probe-and-remove-methods.patch
driver/add-ocp_bus_type-probe-and-remove-methods.patch
driver/add-of_platform_bus_type-probe-and-remove-methods.patch
driver/add-parisc_bus_type-probe-and-remove-methods.patch
driver/add-pci_bus_type-probe-and-remove-methods.patch
driver/add-pcmcia_bus_type-probe-and-remove-methods.patch
driver/add-pnp_bus_type-probe-and-remove-methods.patch
driver/add-pseudo-lld-bus_type-probe-and-remove-methods.patch
driver/add-rio_bus_type-probe-and-remove-methods.patch
driver/add-sa1111-bus_type-probe-remove-methods.patch
driver/add-serio-bus_type-probe-and-remove-methods.patch
driver/add-sh_bus_type-probe-and-remove-methods.patch
driver/add-superhyway_bus_type-probe-and-remove-methods.patch
driver/add-tiocx-bus_type-probe-remove-methods.patch
driver/add-usb_serial_bus_type-probe-and-remove-methods.patch
driver/add-vio_bus_type-probe-and-remove-methods.patch
driver/add-zorro_bus_type-probe-and-remove-methods.patch
driver/remove-usb-gadget-generic-driver-methods.patch
