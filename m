Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6DC882C02A3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 15:21:33 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 20 Jun 2013 01:21:30 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id E37E038C804A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 01:21:27 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5K5LSHb244310
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 01:21:28 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5K5LRKq001259
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 01:21:28 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 01/31] powerpc/eeh: Cleanup for EEH core
Date: Thu, 20 Jun 2013 13:20:51 +0800
Message-Id: <1371705681-24632-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1371705681-24632-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1371705681-24632-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cleanup on EEH core to remove unnecessary whitespaces.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh.c        |   22 +++++++++++-----------
 arch/powerpc/platforms/pseries/eeh_driver.c |   14 +++++++-------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 6b73d6c..8a83451 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -368,7 +368,7 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
 	}
 
 	eeh_stats.slot_resets++;
- 
+
 	/* Avoid repeated reports of this failure, including problems
 	 * with other functions on this device, and functions under
 	 * bridges.
@@ -525,7 +525,7 @@ static void eeh_reset_pe_once(struct eeh_pe *pe)
 	 * or a fundamental reset (3).
 	 * A fundamental reset required by any device under
 	 * Partitionable Endpoint trumps hot-reset.
-  	 */
+	 */
 	eeh_pe_dev_traverse(pe, eeh_set_dev_freset, &freset);
 
 	if (freset)
@@ -538,8 +538,8 @@ static void eeh_reset_pe_once(struct eeh_pe *pe)
 	 */
 #define PCI_BUS_RST_HOLD_TIME_MSEC 250
 	msleep(PCI_BUS_RST_HOLD_TIME_MSEC);
-	
-	/* We might get hit with another EEH freeze as soon as the 
+
+	/* We might get hit with another EEH freeze as soon as the
 	 * pci slot reset line is dropped. Make sure we don't miss
 	 * these, and clear the flag now.
 	 */
@@ -604,7 +604,7 @@ void eeh_save_bars(struct eeh_dev *edev)
 	if (!edev)
 		return;
 	dn = eeh_dev_to_of_node(edev);
-	
+
 	for (i = 0; i < 16; i++)
 		eeh_ops->read_config(dn, i * 4, 4, &edev->config_space[i]);
 }
@@ -803,12 +803,12 @@ void eeh_add_device_tree_late(struct pci_bus *bus)
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
- 		eeh_add_device_late(dev);
- 		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
- 			struct pci_bus *subbus = dev->subordinate;
- 			if (subbus)
- 				eeh_add_device_tree_late(subbus);
- 		}
+		eeh_add_device_late(dev);
+		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+			struct pci_bus *subbus = dev->subordinate;
+			if (subbus)
+				eeh_add_device_tree_late(subbus);
+		}
 	}
 }
 EXPORT_SYMBOL_GPL(eeh_add_device_tree_late);
diff --git a/arch/powerpc/platforms/pseries/eeh_driver.c b/arch/powerpc/platforms/pseries/eeh_driver.c
index a3fefb6..0acc5a2 100644
--- a/arch/powerpc/platforms/pseries/eeh_driver.c
+++ b/arch/powerpc/platforms/pseries/eeh_driver.c
@@ -154,9 +154,9 @@ static void eeh_enable_irq(struct pci_dev *dev)
  * eeh_report_error - Report pci error to each device driver
  * @data: eeh device
  * @userdata: return value
- * 
- * Report an EEH error to each device driver, collect up and 
- * merge the device driver responses. Cumulative response 
+ *
+ * Report an EEH error to each device driver, collect up and
+ * merge the device driver responses. Cumulative response
  * passed back in "userdata".
  */
 static void *eeh_report_error(void *data, void *userdata)
@@ -376,9 +376,9 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 	eeh_pe_restore_bars(pe);
 
 	/* Give the system 5 seconds to finish running the user-space
-	 * hotplug shutdown scripts, e.g. ifdown for ethernet.  Yes, 
-	 * this is a hack, but if we don't do this, and try to bring 
-	 * the device up before the scripts have taken it down, 
+	 * hotplug shutdown scripts, e.g. ifdown for ethernet.  Yes,
+	 * this is a hack, but if we don't do this, and try to bring
+	 * the device up before the scripts have taken it down,
 	 * potentially weird things happen.
 	 */
 	if (bus) {
@@ -520,7 +520,7 @@ void eeh_handle_event(struct eeh_pe *pe)
 	eeh_pe_dev_traverse(pe, eeh_report_resume, NULL);
 
 	return;
-	
+
 excess_failures:
 	/*
 	 * About 90% of all real-life EEH failures in the field
-- 
1.7.5.4
