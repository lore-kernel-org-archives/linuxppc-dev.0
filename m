Return-Path: <geoff@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 018561A0B4F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 04:42:06 +1000 (AEST)
Message-ID: <1438022522.1657.42.camel@infradead.org>
Subject: [PATCH] drivers/ps3: Fix ps3-lpm white space
From: Geoff Levand <geoff@infradead.org>
To: trivial@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Rudhresh
 Kumar J <rudhresh.jk@gmail.com>
Date: Mon, 27 Jul 2015 11:42:02 -0700
In-Reply-To: <1438004938-2280-1-git-send-email-rudhresh.jk@gmail.com>
References: <1438004938-2280-1-git-send-email-rudhresh.jk@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Rudhresh Kumar J <rudhresh.jk@gmail.com>

Fixed a coding style issue.

Signed-off-by: Rudhresh Kumar J <rudhresh.jk@gmail.com>
Signed-off-by: Geoff Levand <geoff@infradead.org>
---
Please apply to trivial.  Thanks.

-Geoff

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
