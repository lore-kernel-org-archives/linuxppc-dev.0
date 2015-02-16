Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 081F71A08BD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 14:47:03 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CFDB414021A
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:47:02 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 16 Feb 2015 13:47:01 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D354B2BB0040
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:46:58 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1G3kohb46661886
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:46:58 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1G3kPqc005694
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:46:25 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 01/10] powerpc/powernv: Shorten EEH function names
Date: Mon, 16 Feb 2015 14:45:39 +1100
Message-Id: <1424058348-28951-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1424058348-28951-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1424058348-28951-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch shortens names of EEH functions in powernv-eeh.c and no
logic change introduced by this patch.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 104 +++++++++++++--------------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index e261869..f562dd1 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -39,11 +39,11 @@
 #include "pci.h"
 
 /**
- * powernv_eeh_init - EEH platform dependent initialization
+ * pnv_eeh_init - EEH platform dependent initialization
  *
  * EEH platform dependent initialization on powernv
  */
-static int powernv_eeh_init(void)
+static int pnv_eeh_init(void)
 {
 	struct pci_controller *hose;
 	struct pnv_phb *phb;
@@ -86,14 +86,14 @@ static int powernv_eeh_init(void)
 }
 
 /**
- * powernv_eeh_post_init - EEH platform dependent post initialization
+ * pnv_eeh_post_init - EEH platform dependent post initialization
  *
  * EEH platform dependent post initialization on powernv. When
  * the function is called, the EEH PEs and devices should have
  * been built. If the I/O cache staff has been built, EEH is
  * ready to supply service.
  */
-static int powernv_eeh_post_init(void)
+static int pnv_eeh_post_init(void)
 {
 	struct pci_controller *hose;
 	struct pnv_phb *phb;
@@ -113,7 +113,7 @@ static int powernv_eeh_post_init(void)
 }
 
 /**
- * powernv_eeh_dev_probe - Do probe on PCI device
+ * pnv_eeh_dev_probe - Do probe on PCI device
  * @dev: PCI device
  * @flag: unused
  *
@@ -129,7 +129,7 @@ static int powernv_eeh_post_init(void)
  * was possiblly triggered by EEH core, the binding between EEH device
  * and the PCI device isn't built yet.
  */
-static int powernv_eeh_dev_probe(struct pci_dev *dev, void *flag)
+static int pnv_eeh_dev_probe(struct pci_dev *dev, void *flag)
 {
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
 	struct pnv_phb *phb = hose->private_data;
@@ -221,7 +221,7 @@ static int powernv_eeh_dev_probe(struct pci_dev *dev, void *flag)
 }
 
 /**
- * powernv_eeh_set_option - Initialize EEH or MMIO/DMA reenable
+ * pnv_eeh_set_option - Initialize EEH or MMIO/DMA reenable
  * @pe: EEH PE
  * @option: operation to be issued
  *
@@ -229,7 +229,7 @@ static int powernv_eeh_dev_probe(struct pci_dev *dev, void *flag)
  * Currently, following options are support according to PAPR:
  * Enable EEH, Disable EEH, Enable MMIO and Enable DMA
  */
-static int powernv_eeh_set_option(struct eeh_pe *pe, int option)
+static int pnv_eeh_set_option(struct eeh_pe *pe, int option)
 {
 	struct pci_controller *hose = pe->phb;
 	struct pnv_phb *phb = hose->private_data;
@@ -246,19 +246,19 @@ static int powernv_eeh_set_option(struct eeh_pe *pe, int option)
 }
 
 /**
- * powernv_eeh_get_pe_addr - Retrieve PE address
+ * pnv_eeh_get_pe_addr - Retrieve PE address
  * @pe: EEH PE
  *
  * Retrieve the PE address according to the given tranditional
  * PCI BDF (Bus/Device/Function) address.
  */
-static int powernv_eeh_get_pe_addr(struct eeh_pe *pe)
+static int pnv_eeh_get_pe_addr(struct eeh_pe *pe)
 {
 	return pe->addr;
 }
 
 /**
- * powernv_eeh_get_state - Retrieve PE state
+ * pnv_eeh_get_state - Retrieve PE state
  * @pe: EEH PE
  * @delay: delay while PE state is temporarily unavailable
  *
@@ -267,7 +267,7 @@ static int powernv_eeh_get_pe_addr(struct eeh_pe *pe)
  * we prefer passing down to hardware implementation to handle
  * it.
  */
-static int powernv_eeh_get_state(struct eeh_pe *pe, int *delay)
+static int pnv_eeh_get_state(struct eeh_pe *pe, int *delay)
 {
 	struct pci_controller *hose = pe->phb;
 	struct pnv_phb *phb = hose->private_data;
@@ -292,13 +292,13 @@ static int powernv_eeh_get_state(struct eeh_pe *pe, int *delay)
 }
 
 /**
- * powernv_eeh_reset - Reset the specified PE
+ * pnv_eeh_reset - Reset the specified PE
  * @pe: EEH PE
  * @option: reset option
  *
  * Reset the specified PE
  */
-static int powernv_eeh_reset(struct eeh_pe *pe, int option)
+static int pnv_eeh_reset(struct eeh_pe *pe, int option)
 {
 	struct pci_controller *hose = pe->phb;
 	struct pnv_phb *phb = hose->private_data;
@@ -311,20 +311,20 @@ static int powernv_eeh_reset(struct eeh_pe *pe, int option)
 }
 
 /**
- * powernv_eeh_wait_state - Wait for PE state
+ * pnv_eeh_wait_state - Wait for PE state
  * @pe: EEH PE
  * @max_wait: maximal period in microsecond
  *
  * Wait for the state of associated PE. It might take some time
  * to retrieve the PE's state.
  */
-static int powernv_eeh_wait_state(struct eeh_pe *pe, int max_wait)
+static int pnv_eeh_wait_state(struct eeh_pe *pe, int max_wait)
 {
 	int ret;
 	int mwait;
 
 	while (1) {
-		ret = powernv_eeh_get_state(pe, &mwait);
+		ret = pnv_eeh_get_state(pe, &mwait);
 
 		/*
 		 * If the PE's state is temporarily unavailable,
@@ -348,7 +348,7 @@ static int powernv_eeh_wait_state(struct eeh_pe *pe, int max_wait)
 }
 
 /**
- * powernv_eeh_get_log - Retrieve error log
+ * pnv_eeh_get_log - Retrieve error log
  * @pe: EEH PE
  * @severity: temporary or permanent error log
  * @drv_log: driver log to be combined with retrieved error log
@@ -356,8 +356,8 @@ static int powernv_eeh_wait_state(struct eeh_pe *pe, int max_wait)
  *
  * Retrieve the temporary or permanent error from the PE.
  */
-static int powernv_eeh_get_log(struct eeh_pe *pe, int severity,
-			       char *drv_log, unsigned long len)
+static int pnv_eeh_get_log(struct eeh_pe *pe, int severity,
+			   char *drv_log, unsigned long len)
 {
 	struct pci_controller *hose = pe->phb;
 	struct pnv_phb *phb = hose->private_data;
@@ -370,14 +370,14 @@ static int powernv_eeh_get_log(struct eeh_pe *pe, int severity,
 }
 
 /**
- * powernv_eeh_configure_bridge - Configure PCI bridges in the indicated PE
+ * pnv_eeh_configure_bridge - Configure PCI bridges in the indicated PE
  * @pe: EEH PE
  *
  * The function will be called to reconfigure the bridges included
  * in the specified PE so that the mulfunctional PE would be recovered
  * again.
  */
-static int powernv_eeh_configure_bridge(struct eeh_pe *pe)
+static int pnv_eeh_configure_bridge(struct eeh_pe *pe)
 {
 	struct pci_controller *hose = pe->phb;
 	struct pnv_phb *phb = hose->private_data;
@@ -390,7 +390,7 @@ static int powernv_eeh_configure_bridge(struct eeh_pe *pe)
 }
 
 /**
- * powernv_pe_err_inject - Inject specified error to the indicated PE
+ * pnv_pe_err_inject - Inject specified error to the indicated PE
  * @pe: the indicated PE
  * @type: error type
  * @func: specific error type
@@ -401,8 +401,8 @@ static int powernv_eeh_configure_bridge(struct eeh_pe *pe)
  * determined by @type and @func, to the indicated PE for
  * testing purpose.
  */
-static int powernv_eeh_err_inject(struct eeh_pe *pe, int type, int func,
-				  unsigned long addr, unsigned long mask)
+static int pnv_eeh_err_inject(struct eeh_pe *pe, int type, int func,
+			      unsigned long addr, unsigned long mask)
 {
 	struct pci_controller *hose = pe->phb;
 	struct pnv_phb *phb = hose->private_data;
@@ -414,7 +414,7 @@ static int powernv_eeh_err_inject(struct eeh_pe *pe, int type, int func,
 	return ret;
 }
 
-static inline bool powernv_eeh_cfg_blocked(struct device_node *dn)
+static inline bool pnv_eeh_cfg_blocked(struct device_node *dn)
 {
 	struct eeh_dev *edev = of_node_to_eeh_dev(dn);
 
@@ -427,10 +427,10 @@ static inline bool powernv_eeh_cfg_blocked(struct device_node *dn)
 	return false;
 }
 
-static int powernv_eeh_read_config(struct device_node *dn,
-				   int where, int size, u32 *val)
+static int pnv_eeh_read_config(struct device_node *dn,
+			       int where, int size, u32 *val)
 {
-	if (powernv_eeh_cfg_blocked(dn)) {
+	if (pnv_eeh_cfg_blocked(dn)) {
 		*val = 0xFFFFFFFF;
 		return PCIBIOS_SET_FAILED;
 	}
@@ -438,22 +438,22 @@ static int powernv_eeh_read_config(struct device_node *dn,
 	return pnv_pci_cfg_read(dn, where, size, val);
 }
 
-static int powernv_eeh_write_config(struct device_node *dn,
-				    int where, int size, u32 val)
+static int pnv_eeh_write_config(struct device_node *dn,
+				int where, int size, u32 val)
 {
-	if (powernv_eeh_cfg_blocked(dn))
+	if (pnv_eeh_cfg_blocked(dn))
 		return PCIBIOS_SET_FAILED;
 
 	return pnv_pci_cfg_write(dn, where, size, val);
 }
 
 /**
- * powernv_eeh_next_error - Retrieve next EEH error to handle
+ * pnv_eeh_next_error - Retrieve next EEH error to handle
  * @pe: Affected PE
  *
  * Using OPAL API, to retrieve next EEH error for EEH core to handle
  */
-static int powernv_eeh_next_error(struct eeh_pe **pe)
+static int pnv_eeh_next_error(struct eeh_pe **pe)
 {
 	struct pci_controller *hose;
 	struct pnv_phb *phb = NULL;
@@ -469,7 +469,7 @@ static int powernv_eeh_next_error(struct eeh_pe **pe)
 	return -EEXIST;
 }
 
-static int powernv_eeh_restore_config(struct device_node *dn)
+static int pnv_eeh_restore_config(struct device_node *dn)
 {
 	struct eeh_dev *edev = of_node_to_eeh_dev(dn);
 	struct pnv_phb *phb;
@@ -490,24 +490,24 @@ static int powernv_eeh_restore_config(struct device_node *dn)
 	return 0;
 }
 
-static struct eeh_ops powernv_eeh_ops = {
+static struct eeh_ops pnv_eeh_ops = {
 	.name                   = "powernv",
-	.init                   = powernv_eeh_init,
-	.post_init              = powernv_eeh_post_init,
+	.init                   = pnv_eeh_init,
+	.post_init              = pnv_eeh_post_init,
 	.of_probe               = NULL,
-	.dev_probe              = powernv_eeh_dev_probe,
-	.set_option             = powernv_eeh_set_option,
-	.get_pe_addr            = powernv_eeh_get_pe_addr,
-	.get_state              = powernv_eeh_get_state,
-	.reset                  = powernv_eeh_reset,
-	.wait_state             = powernv_eeh_wait_state,
-	.get_log                = powernv_eeh_get_log,
-	.configure_bridge       = powernv_eeh_configure_bridge,
-	.err_inject		= powernv_eeh_err_inject,
-	.read_config            = powernv_eeh_read_config,
-	.write_config           = powernv_eeh_write_config,
-	.next_error		= powernv_eeh_next_error,
-	.restore_config		= powernv_eeh_restore_config
+	.dev_probe              = pnv_eeh_dev_probe,
+	.set_option             = pnv_eeh_set_option,
+	.get_pe_addr            = pnv_eeh_get_pe_addr,
+	.get_state              = pnv_eeh_get_state,
+	.reset                  = pnv_eeh_reset,
+	.wait_state             = pnv_eeh_wait_state,
+	.get_log                = pnv_eeh_get_log,
+	.configure_bridge       = pnv_eeh_configure_bridge,
+	.err_inject		= pnv_eeh_err_inject,
+	.read_config            = pnv_eeh_read_config,
+	.write_config           = pnv_eeh_write_config,
+	.next_error		= pnv_eeh_next_error,
+	.restore_config		= pnv_eeh_restore_config
 };
 
 /**
@@ -521,7 +521,7 @@ static int __init eeh_powernv_init(void)
 	int ret = -EINVAL;
 
 	eeh_set_pe_aux_size(PNV_PCI_DIAG_BUF_SIZE);
-	ret = eeh_ops_register(&powernv_eeh_ops);
+	ret = eeh_ops_register(&pnv_eeh_ops);
 	if (!ret)
 		pr_info("EEH: PowerNV platform initialized\n");
 	else
-- 
1.8.3.2
