Return-Path: <B16395@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B42E92C0B87
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:59:46 +1100 (EST)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <iommu@lists.linux-foundation.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <scottwood@freescale.com>, <joro@8bytes.org>,
 <stuart.yoder@freescale.com>
Subject: [PATCH 3/6] powerpc/fsl_pci: Added defines for the FSL PCI controller
 BRR1 register.
Date: Mon, 18 Feb 2013 18:22:16 +0530
Message-ID: <1361191939-21260-4-git-send-email-Varun.Sethi@freescale.com>
In-Reply-To: <1361191939-21260-1-git-send-email-Varun.Sethi@freescale.com>
References: <1361191939-21260-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Macros for checking FSL PCI controller version.

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
---
 arch/powerpc/include/asm/pci-bridge.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 025a130..c12ed78 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -14,6 +14,10 @@
 
 struct device_node;
 
+/* FSL PCI controller BRR1 register */
+#define PCI_FSL_BRR1      0xbf8
+#define PCI_FSL_BRR1_VER 0xffff
+
 /*
  * Structure of a PCI controller (host bridge)
  */
-- 
1.7.4.1
