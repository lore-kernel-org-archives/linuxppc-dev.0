Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id D968FDDDB6
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Mar 2009 08:07:20 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id j37so923649waf.9
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Mar 2009 14:07:19 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] powerpc: Remove unused symbols from fsl_devices.h
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Date: Sat, 28 Mar 2009 15:07:16 -0600
Message-ID: <20090328210715.27260.66043.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Greg Kroah-Hartmann <greg@kroah.com>, Kay Sievers <kay.sievers@vrfy.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Remove old artifacts leftover from the platform driver gianfar and
fsl_i2c drivers.  These symbols became unused when the drivers
were migrated over to use the of_platform bus.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 include/linux/fsl_devices.h |   22 ----------------------
 1 files changed, 0 insertions(+), 22 deletions(-)


diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index d9051d7..4953709 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -18,7 +18,6 @@
 #define _FSL_DEVICE_H_
 
 #include <linux/types.h>
-#include <linux/phy.h>
 
 /*
  * Some conventions on how we handle peripherals on Freescale chips
@@ -44,27 +43,6 @@
  *
  */
 
-struct gianfar_platform_data {
-	/* device specific information */
-	u32	device_flags;
-	char	bus_id[BUS_ID_SIZE];
-	phy_interface_t interface;
-};
-
-struct gianfar_mdio_data {
-	/* board specific information */
-	int	irq[32];
-};
-
-/* Flags in gianfar_platform_data */
-#define FSL_GIANFAR_BRD_HAS_PHY_INTR	0x00000001 /* set or use a timer */
-#define FSL_GIANFAR_BRD_IS_REDUCED	0x00000002 /* Set if RGMII, RMII */
-
-struct fsl_i2c_platform_data {
-	/* device specific information */
-	u32	device_flags;
-};
-
 /* Flags related to I2C device features */
 #define FSL_I2C_DEV_SEPARATE_DFSRR	0x00000001
 #define FSL_I2C_DEV_CLOCK_5200		0x00000002
