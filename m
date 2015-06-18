Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7640D1A0AE3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2015 15:15:10 +1000 (AEST)
Message-ID: <1434604510.2942.33.camel@neuling.org>
Subject: [PATCH] cxl: Fix typo in debug print
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>, benh <benh@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Ian Munsie
 <ianmunsi@au1.ibm.com>
Date: Thu, 18 Jun 2015 15:15:10 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix typo in debug print.  p1->p2.  No functional change.

Signed-off-by: Michael Neuling <mikey@neuling.org>

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 1ef0164..8515791 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -204,7 +204,7 @@ static void dump_cxl_config_space(struct pci_dev *dev)
 	dev_info(&dev->dev, "p1 regs: %#llx, len: %#llx\n",
 		p1_base(dev), p1_size(dev));
 	dev_info(&dev->dev, "p2 regs: %#llx, len: %#llx\n",
-		p1_base(dev), p2_size(dev));
+		p2_base(dev), p2_size(dev));
 	dev_info(&dev->dev, "BAR 4/5: %#llx, len: %#llx\n",
 		pci_resource_start(dev, 4), pci_resource_len(dev, 4));
=20
