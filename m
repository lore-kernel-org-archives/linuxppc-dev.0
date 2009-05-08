Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E7967DDE0F
	for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2009 23:53:01 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: pierre@ossman.eu
Subject: [PATCH] mmc: Add fsl,esdhc as a valid compatible to bind against
Date: Fri,  8 May 2009 08:52:49 -0500
Message-Id: <1241790769-3843-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We plan to use fsl,esdhc going forward as the base compatible so update
the driver to bind against it.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 drivers/mmc/host/sdhci-of.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of.c b/drivers/mmc/host/sdhci-of.c
index 3ff4ac3..09cc597 100644
--- a/drivers/mmc/host/sdhci-of.c
+++ b/drivers/mmc/host/sdhci-of.c
@@ -277,6 +277,7 @@ static int __devexit sdhci_of_remove(struct of_device *ofdev)
 static const struct of_device_id sdhci_of_match[] = {
 	{ .compatible = "fsl,mpc8379-esdhc", .data = &sdhci_esdhc, },
 	{ .compatible = "fsl,mpc8536-esdhc", .data = &sdhci_esdhc, },
+	{ .compatible = "fsl,esdhc", .data = &sdhci_esdhc, },
 	{ .compatible = "generic-sdhci", },
 	{},
 };
-- 
1.6.0.6
