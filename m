Message-ID: <3D41DCB4.90706@dslextreme.com>
Date: Fri, 26 Jul 2002 16:35:16 -0700
From: akuster <akuster@dslextreme.com>
Reply-To: akuster@dslextreme.com
MIME-Version: 1.0
To: akuster@dslextreme.com
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC/Patch] ppc4xx_pm.c
References: <3D3DD903.3070300@dslextreme.com>
Content-Type: multipart/mixed;
 boundary="------------070602060700000809060608"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------070602060700000809060608
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

akuster wrote:
>
> I am in the process of fixing the init of the pm for 4xx in ppc4xx_pm.c
> so that it can be used and I and others have discussed having the
> drivers enable/disable their own power managment bits at init & exit times.
>

>
> 2) update ocp drivers to enable/disable their pm settings and remove
> their enable bits from the default bitmap in the core headers.

Here are the ocp driver changes to help support enabling/disabling the
device clock.  currently these wount work on the 440 until a soon to
follow on 440 patch is checked in

armin


--------------070602060700000809060608
Content-Type: application/x-gunzip;
 name="pm_drv_update_0726.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="pm_drv_update_0726.patch.gz"

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
--------------070602060700000809060608
Content-Type: text/plain;
 name="pm_drv_update_0726.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pm_drv_update_0726.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux 2.4 for PowerPC development tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1096  -> 1.1097
#	drivers/net/ibm_ocp/ibm_ocp_enet.c	1.53    -> 1.54
#	drivers/net/ibm_ocp/ibm_ocp_enet.h	1.29    -> 1.30
#	drivers/i2c/i2c-adap-ibm_ocp.c	1.9     -> 1.10
#	drivers/char/ibm_ocp_gpio.c	1.13    -> 1.14
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/26	armin@essen.mvista.com	1.1097
# udated drivers for CPM support
# --------------------------------------------
#
diff -Nru a/drivers/char/ibm_ocp_gpio.c b/drivers/char/ibm_ocp_gpio.c
--- a/drivers/char/ibm_ocp_gpio.c	Fri Jul 26 10:04:10 2002
+++ b/drivers/char/ibm_ocp_gpio.c	Fri Jul 26 10:04:10 2002
@@ -58,9 +58,12 @@
  *	an accessible area.  Add ioctl to configure
  *	multiplexed GPIO pins.
  *
+ *	1.7 07/25/02 - Armin
+ *	added CPM to enable/disable in init/exit
+ *
  */

-#define VUFX "06.04.02"
+#define VUFX "07.25.02"

 #include <linux/module.h>
 #include <linux/config.h>
@@ -283,7 +286,7 @@
 			return -EFAULT;

 		return ibm_gpio_config(ioctl_data.device,
-					 ioctl_data.mask, ioctl_data.data);
+				       ioctl_data.mask, ioctl_data.data);

 		break;

@@ -322,7 +325,12 @@
 			ibm_gpio_miscdev.fops = &ibm_gpio_fops;
 			misc_register(&ibm_gpio_miscdev);	/*ibm_gpio_miscdev); */

-			gpiop = (struct gpio_regs *)ioremap(gpio_dev->paddr, sizeof(struct gpio_regs));
+			gpiop =
+			    (struct gpio_regs *) ioremap(gpio_dev->paddr,
+							 sizeof (struct
+								 gpio_regs));
+			mtdcr(DCRN_CPMFR,
+			      mfdcr(DCRN_CPMFR) & ~ocp_get_pm(GPIO, curr_gpio));
 			printk("GPIO #%d at 0x%lx\n", curr_gpio,
 			       (unsigned long) gpiop);

@@ -341,6 +349,7 @@
 	for (i = 0; i < ocp_get_max(GPIO); i++) {
 		gpio_dev = ocp_get_dev(GPIO, i);
 		misc_deregister(&ibm_gpio_miscdev);
+		mtdcr(DCRN_CPMFR, mfdcr(DCRN_CPMFR) | ocp_get_pm(GPIO, i));
 		ocp_unregister(gpio_dev);
 	}
 }
diff -Nru a/drivers/i2c/i2c-adap-ibm_ocp.c b/drivers/i2c/i2c-adap-ibm_ocp.c
--- a/drivers/i2c/i2c-adap-ibm_ocp.c	Fri Jul 26 10:04:10 2002
+++ b/drivers/i2c/i2c-adap-ibm_ocp.c	Fri Jul 26 10:04:10 2002
@@ -66,6 +66,9 @@
     Version: 1.9 - Armin
        changed irq_resource to just irq

+    Version: 2.0 - Armin
+    	added CPM enable/disable in init/exit
+
    TODO: add PM hooks

 */
@@ -269,6 +272,7 @@
 			adap->dec_use = iic_ibmocp_dec_use;
 			adap->client_register = iic_ibmocp_reg;
 			adap->client_unregister = iic_ibmocp_unreg;
+			mtdcr(DCRN_CPMFR, mfdcr(DCRN_CPMFR) & ~ocp_get_pm(IIC, curr_iic));

 			init_waitqueue_head(&(iic_wait[curr_iic]));

@@ -312,6 +316,7 @@
 		iic_drv = ocp_get_dev(IIC, i);
 		adap = (struct i2c_adapter *) iic_drv->ocpdev;
 		i2c_iic_del_bus(adap);
+		mtdcr(DCRN_CPMFR, mfdcr(DCRN_CPMFR) | ocp_get_pm(IIC, i));
 	}

 	iic_ibmocp_release();
diff -Nru a/drivers/net/ibm_ocp/ibm_ocp_enet.c b/drivers/net/ibm_ocp/ibm_ocp_enet.c
--- a/drivers/net/ibm_ocp/ibm_ocp_enet.c	Fri Jul 26 10:04:10 2002
+++ b/drivers/net/ibm_ocp/ibm_ocp_enet.c	Fri Jul 26 10:04:10 2002
@@ -167,6 +167,8 @@
  *      removed need for irq_resource
  *	removed need for loop in request & free irq
  *	changed interrupt handles to static
+ *	 Version 4.7 07/25/02 - Armin
+ *	    added CPM enable/diable in init/exit
  *
  */
 #include <linux/module.h>
@@ -619,6 +621,10 @@
 	rx_virt_addr = (mal_desc_t *)
 	    consistent_alloc(GFP_KERNEL, PAGE_SIZE * emac_max, &rx_phys_addr);
 	for (curr_emac = 0; curr_emac < emac_max; curr_emac++) {
+		if(ocp_get_pm(EMAC, curr_emac)){
+			mtdcr(DCRN_CPMFR,
+			      mfdcr(DCRN_CPMFR) & ~IBM_CPM_EMAC(ocp_get_pm(EMAC, curr_emac)));
+		}
 		ocp_enet_probe(curr_emac);
 	}

@@ -1193,6 +1199,17 @@
 static void __exit
 exit_ppc405_enet(void)
 {
+	int i;
+	struct ocp_dev *emac_dev;
+
+	for (i = 0; i < ocp_get_max(EMAC); i++) {
+		emac_dev = ocp_get_dev(EMAC, i);
+		if(ocp_get_pm(EMAC, i)){
+			mtdcr(DCRN_CPMFR, mfdcr(DCRN_CPMFR) | IBM_CPM_EMAC(ocp_get_pm(EMAC, i)));
+			ocp_unregister(emac_dev);
+		}
+	}
+
 	/*
 	 * Unmap the non cached memory space.
 	 */
diff -Nru a/drivers/net/ibm_ocp/ibm_ocp_enet.h b/drivers/net/ibm_ocp/ibm_ocp_enet.h
--- a/drivers/net/ibm_ocp/ibm_ocp_enet.h	Fri Jul 26 10:04:10 2002
+++ b/drivers/net/ibm_ocp/ibm_ocp_enet.h	Fri Jul 26 10:04:10 2002
@@ -93,6 +93,11 @@
 #define MDIO_DELAY		2
 #define NMII				20

+/* Power managment shift registers */
+#define IBM_CPM_EMMII	0	/* Shift value for MII */
+#define IBM_CPM_EMRX	1	/* Shift value for recv */
+#define IBM_CPM_EMTX	2	/* Shift value for MAC */
+#define IBM_CPM_EMAC(x)	(((x)<<IBM_CPM_EMMII) | ((x)<<IBM_CPM_EMRX) | ((x)<<IBM_CPM_EMTX))

 #ifdef CONFIG_IBM_OCP_ENET_ERROR_MSG
 void ppc405_serr_dump_0(struct net_device *dev);

--------------070602060700000809060608--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
