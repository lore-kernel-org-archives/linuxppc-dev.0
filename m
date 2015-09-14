Return-Path: <geoff@infradead.org>
Message-Id: <465f0dccd656edb00f00f45cb8034f9a8825f19e.1442259101.git.geoff@infradead.org>
In-Reply-To: <cover.1442259101.git.geoff@infradead.org>
References: <cover.1442259101.git.geoff@infradead.org>
From: Rudhresh Kumar J <rudhresh.jk@gmail.com>
Subject: [PATCH 1/3] drivers/ps3: Fix ps3-lpm white space
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 cbe-oss-dev@lists.ozlabs.org, Rudhresh Kumar J <rudhresh.jk@gmail.com>
Sender: Geoff Levand <geoff@infradead.org>
Date: Mon, 14 Sep 2015 19:35:04 +0000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fixed a coding style issue.

Signed-off-by: Rudhresh Kumar J <rudhresh.jk@gmail.com>
Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 drivers/ps3/ps3-lpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ps3/ps3-lpm.c b/drivers/ps3/ps3-lpm.c
index cb7d3a6..e34de9a 100644
--- a/drivers/ps3/ps3-lpm.c
+++ b/drivers/ps3/ps3-lpm.c
@@ -901,7 +901,7 @@ void ps3_disable_pm(u32 cpu)
 	result = lv1_stop_lpm(lpm_priv->lpm_id, &tmp);
 
 	if (result) {
-		if(result != LV1_WRONG_STATE)
+		if (result != LV1_WRONG_STATE)
 			dev_err(sbd_core(), "%s:%u: lv1_stop_lpm failed: %s\n",
 				__func__, __LINE__, ps3_result(result));
 		return;
-- 
2.1.0
