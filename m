Return-Path: <madalin.bucur@nxp.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0069.outbound.protection.outlook.com [104.47.32.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sp9Zf5cHnzDrKY
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 18:31:22 +1100 (AEDT)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <linuxdev.baldrick@gmail.com>, Madalin Bucur
 <madalin.bucur@nxp.com>
Subject: [net-next 01/13] fsl/fman: split lines over 80 characters
Date: Tue, 4 Oct 2016 10:30:25 +0300
Message-ID: <1475566237-4948-2-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1475566237-4948-1-git-send-email-madalin.bucur@nxp.com>
References: <1475566237-4948-1-git-send-email-madalin.bucur@nxp.com>
Reply-To: <madalin.bucur@nxp.com>
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

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/fman/fman_muram.c | 3 ++-
 drivers/net/ethernet/freescale/fman/fman_muram.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman_muram.c b/drivers/net/ethernet/freescale/fman/fman_muram.c
index 47394c4..5ec94d2 100644
--- a/drivers/net/ethernet/freescale/fman/fman_muram.c
+++ b/drivers/net/ethernet/freescale/fman/fman_muram.c
@@ -150,7 +150,8 @@ unsigned long fman_muram_alloc(struct muram_info *muram, size_t size)
  *
  * Free an allocated memory from FM-MURAM partition.
  */
-void fman_muram_free_mem(struct muram_info *muram, unsigned long offset, size_t size)
+void fman_muram_free_mem(struct muram_info *muram, unsigned long offset,
+			 size_t size)
 {
 	unsigned long addr = fman_muram_offset_to_vbase(muram, offset);
 
diff --git a/drivers/net/ethernet/freescale/fman/fman_muram.h b/drivers/net/ethernet/freescale/fman/fman_muram.h
index 889649a..453bf84 100644
--- a/drivers/net/ethernet/freescale/fman/fman_muram.h
+++ b/drivers/net/ethernet/freescale/fman/fman_muram.h
@@ -46,6 +46,7 @@ unsigned long fman_muram_offset_to_vbase(struct muram_info *muram,
 
 unsigned long fman_muram_alloc(struct muram_info *muram, size_t size);
 
-void fman_muram_free_mem(struct muram_info *muram, unsigned long offset, size_t size);
+void fman_muram_free_mem(struct muram_info *muram, unsigned long offset,
+			 size_t size);
 
 #endif /* __FM_MURAM_EXT */
-- 
2.1.0
