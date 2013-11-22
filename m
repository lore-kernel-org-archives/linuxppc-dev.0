Return-Path: <alistair@popple.id.au>
Received: from ipmail04.adl6.internode.on.net (ipmail04.adl6.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:6:4])
 by ozlabs.org (Postfix) with ESMTP id 365E52C032F
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Nov 2013 13:08:45 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: benh@kernel.crashing.org
Subject: [PATCH 1/8] IBM Akebono: Add support to AHCI platform driver
Date: Fri, 22 Nov 2013 13:08:29 +1100
Message-Id: <1385086116-10972-1-git-send-email-alistair@popple.id.au>
In-Reply-To: <1385086057-10884-1-git-send-email-alistair@popple.id.au>
References: <1385086057-10884-1-git-send-email-alistair@popple.id.au>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org,
 Alistair Popple <alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The new IBM Akebono board has a PPC476GTR SoC with an AHCI compliant
SATA controller. This patch adds a compatible property for the new SoC
to the AHCI platform driver.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
Cc: linux-ide@vger.kernel.org
---
 drivers/ata/ahci_platform.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 7d3b853..e247594 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -328,6 +328,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_suspend, ahci_resume);
 static const struct of_device_id ahci_of_match[] = {
 	{ .compatible = "snps,spear-ahci", },
 	{ .compatible = "snps,exynos5440-ahci", },
+	{ .compatible = "ibm,476gtr-ahci", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_of_match);
-- 
1.7.10.4
