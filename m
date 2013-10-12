Return-Path: <B16395@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EB6D22C064D
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Oct 2013 07:47:43 +1100 (EST)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <joro@8bytes.org>, <iommu@lists.linux-foundation.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <stuart.yoder@freescale.com>, <scottwood@freescale.com>,
 <alex.williamson@redhat.com>, <r65777@freescale.com>
Subject: [PATCH 3/3] Add maintainers entry for the Freescale PAMU driver.
Date: Sun, 13 Oct 2013 02:02:34 +0530
Message-ID: <1381609954-15283-4-git-send-email-Varun.Sethi@freescale.com>
In-Reply-To: <1381609954-15283-1-git-send-email-Varun.Sethi@freescale.com>
References: <1381609954-15283-1-git-send-email-Varun.Sethi@freescale.com>
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

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
---
 MAINTAINERS |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a0cbf3..5b6ea5c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3511,6 +3511,13 @@ S:	Maintained
 F:	drivers/net/ethernet/freescale/fs_enet/
 F:	include/linux/fs_enet_pd.h
 
+FREESCALE PAMU DRIVER
+M:	Varun Sethi <varun.sethi@freescale.com>
+L:	linuxppc-dev@lists.ozlabs.org
+L:	iommu@lists.linux-foundation.org
+S:	Maintained
+F:	drivers/iommu/fsl_pamu*
+
 FREESCALE QUICC ENGINE LIBRARY
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Orphan
-- 
1.7.9.5
