Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 419BCDDF6C
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jan 2009 06:40:38 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n0SJQhpZ028431
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2009 13:26:44 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/fsl: Ensure PCI_QUIRKS are enabled for FSL_PCI
Date: Wed, 28 Jan 2009 13:26:43 -0600
Message-Id: <1233170803-12076-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The FSL PCI code depends on PCI quirks being enabled to function
properly.  We can ensure this by doing a select in Kconfig of
PCI_QUIRKS.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index d68ef31..0c95251 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -593,6 +593,7 @@ config FSL_SOC
 config FSL_PCI
  	bool
 	select PPC_INDIRECT_PCI
+	select PCI_QUIRKS
 
 config 4xx_SOC
 	bool
-- 
1.5.6.6
