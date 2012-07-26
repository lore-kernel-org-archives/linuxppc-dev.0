Return-Path: <B04825@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 747822C009E
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2012 01:09:06 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: Kim Phillips <kim.phillips@freescale.com>, Scott Wood
 <scottwood@freescale.com>, Kumar Gala <galak@kernel.crashing.org>,
 <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/3] powerpc/fsl-pci: add fsl,
 qoriq-pcie-v2.4 compatible string
Date: Thu, 26 Jul 2012 10:08:52 -0500
Message-ID: <1343315334-800-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PCI controller on the Freescale P5040 is v2.4.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index a7b2a60..50a38b3 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -818,6 +818,7 @@ static const struct of_device_id pci_ids[] = {
 	{ .compatible = "fsl,p1010-pcie", },
 	{ .compatible = "fsl,p1023-pcie", },
 	{ .compatible = "fsl,p4080-pcie", },
+	{ .compatible = "fsl,qoriq-pcie-v2.4", },
 	{ .compatible = "fsl,qoriq-pcie-v2.3", },
 	{ .compatible = "fsl,qoriq-pcie-v2.2", },
 	{},
-- 
1.7.3.4
