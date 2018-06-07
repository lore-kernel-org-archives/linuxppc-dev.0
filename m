Return-Path: <yangbo.lu@nxp.com>
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411g7H5qbwzF33R
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 19:22:51 +1000 (AEST)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: netdev@vger.kernel.org, madalin.bucur@nxp.com,
 Richard Cochran <richardcochran@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v3, 08/10] fsl/fman: define frame description command UPD
Date: Thu,  7 Jun 2018 17:20:48 +0800
Message-Id: <20180607092050.46128-9-yangbo.lu@nxp.com>
In-Reply-To: <20180607092050.46128-1-yangbo.lu@nxp.com>
References: <20180607092050.46128-1-yangbo.lu@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Defined frame description command FM_FD_CMD_UPD for
prepended data updating.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- None.
Changes for v3:
	- None.
---
 drivers/net/ethernet/freescale/fman/fman.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.h b/drivers/net/ethernet/freescale/fman/fman.h
index bfa02e0..935c317 100644
--- a/drivers/net/ethernet/freescale/fman/fman.h
+++ b/drivers/net/ethernet/freescale/fman/fman.h
@@ -41,6 +41,7 @@
 /* Frame queue Context Override */
 #define FM_FD_CMD_FCO                   0x80000000
 #define FM_FD_CMD_RPD                   0x40000000  /* Read Prepended Data */
+#define FM_FD_CMD_UPD			0x20000000  /* Update Prepended Data */
 #define FM_FD_CMD_DTC                   0x10000000  /* Do L4 Checksum */
 
 /* TX-Port: Unsupported Format */
-- 
1.7.1
