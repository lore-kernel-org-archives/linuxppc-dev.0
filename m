Return-Path: <yguerrini@purch.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0135.outbound.protection.outlook.com [207.46.100.135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A49401A051F
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Mar 2015 00:39:42 +1100 (AEDT)
From: Yannick Guerrini <yguerrini@tomshardware.fr>
To: <geoff@infradead.org>
Subject: [PATCH] ps3: Fix trivial typos in comment and debug message
Date: Sat, 7 Mar 2015 13:03:36 +0100
Message-ID: <1425729816-11084-1-git-send-email-yguerrini@tomshardware.fr>
MIME-Version: 1.0
Content-Type: text/plain
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org, Yannick
 Guerrini <yguerrini@tomshardware.fr>, trivial@kernel.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change 'prosessor' to 'processor'
Change 'set_inteval' to 'set_interval'

Signed-off-by: Yannick Guerrini <yguerrini@tomshardware.fr>
---
 drivers/ps3/ps3-lpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ps3/ps3-lpm.c b/drivers/ps3/ps3-lpm.c
index b139b77..cb7d3a6 100644
--- a/drivers/ps3/ps3-lpm.c
+++ b/drivers/ps3/ps3-lpm.c
@@ -105,7 +105,7 @@ struct ps3_lpm_shadow_regs {
  * @open: An atomic variable indicating the lpm driver has been opened.
  * @rights: The lpm rigths granted by the system policy module.  A logical
  *  OR of enum ps3_lpm_rights.
- * @node_id: The node id of a BE prosessor whose performance monitor this
+ * @node_id: The node id of a BE processor whose performance monitor this
  *  lpar has the right to use.
  * @pu_id: The lv1 id of the logical PU.
  * @lpm_id: The lv1 id of this lpm instance.
@@ -412,7 +412,7 @@ u32 ps3_read_pm(u32 cpu, enum pm_reg_name reg)
 		result = lv1_set_lpm_interval(lpm_priv->lpm_id, 0, 0, &val);
 		if (result) {
 			val = 0;
-			dev_dbg(sbd_core(), "%s:%u: lv1 set_inteval failed: "
+			dev_dbg(sbd_core(), "%s:%u: lv1 set_interval failed: "
 				"reg %u, %s\n", __func__, __LINE__, reg,
 				ps3_result(result));
 		}
-- 
1.9.5.msysgit.0
