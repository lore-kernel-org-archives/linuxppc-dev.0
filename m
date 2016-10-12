Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svFml4cGrzDsss
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 00:57:43 +1100 (AEDT)
Subject: [PATCH v2 2/7] PCI: layerscape: Remove unused platform data
To: Minghuan Lian <minghuan.Lian@freescale.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 12 Oct 2016 08:57:38 -0500
Message-ID: <20161012135738.29815.19822.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012135413.29815.75484.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012135413.29815.75484.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The layerscape driver never uses the platform drvdata pointer, so don't
bother setting it.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-layerscape.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index 08b511e..ebed415 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -267,8 +267,6 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	platform_set_drvdata(pdev, pcie);
-
 	return 0;
 }
 
