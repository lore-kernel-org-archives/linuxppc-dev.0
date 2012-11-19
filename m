Return-Path: <wfp5p@viridian.itc.virginia.edu>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
 [128.143.12.139]) by ozlabs.org (Postfix) with ESMTP id 35E052C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 05:38:01 +1100 (EST)
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 373/493] drivers/macintosh: remove use of __devinitconst
Date: Mon, 19 Nov 2012 13:25:22 -0500
Message-Id: <1353349642-3677-373-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_HOTPLUG is going away as an option so __devinitconst is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org> 
Cc: linuxppc-dev@lists.ozlabs.org 
---
 drivers/macintosh/macio_asic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index 2cdbd47..31617fd 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -748,7 +748,7 @@ static void __devexit macio_pci_remove(struct pci_dev* pdev)
  * MacIO is matched against any Apple ID, it's probe() function
  * will then decide wether it applies or not
  */
-static const struct pci_device_id __devinitconst pci_ids[] = { {
+static const struct pci_device_id pci_ids[] = { {
 	.vendor		= PCI_VENDOR_ID_APPLE,
 	.device		= PCI_ANY_ID,
 	.subvendor	= PCI_ANY_ID,
-- 
1.8.0
