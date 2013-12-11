Return-Path: <Shengzhou.Liu@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4AB9E2C031D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 23:10:10 +1100 (EST)
Received: from mail160-va3 (localhost [127.0.0.1])	by
 mail160-va3-R.bigfish.com (Postfix) with ESMTP id CE6BC4400F6	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 12:10:05 +0000 (UTC)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH 2/5] powerpc/fsl_pci: add versionless pci compatible
Date: Wed, 11 Dec 2013 19:19:31 +0800
Message-ID: <1386760774-14743-2-git-send-email-Shengzhou.Liu@freescale.com>
In-Reply-To: <1386760774-14743-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1386760774-14743-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are much pci compatible with version on existing platforms.
To stop putting version numbers in device tree later, we add a
generic compatible 'fsl,qoriq-pcie'.
The version number is readable directly from a register.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 4dfd61d..a7c71ff 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -1035,6 +1035,7 @@ static const struct of_device_id pci_ids[] = {
 	{ .compatible = "fsl,mpc8548-pcie", },
 	{ .compatible = "fsl,mpc8610-pci", },
 	{ .compatible = "fsl,mpc8641-pcie", },
+	{ .compatible = "fsl,qoriq-pcie", },
 	{ .compatible = "fsl,qoriq-pcie-v2.1", },
 	{ .compatible = "fsl,qoriq-pcie-v2.2", },
 	{ .compatible = "fsl,qoriq-pcie-v2.3", },
-- 
1.8.0
