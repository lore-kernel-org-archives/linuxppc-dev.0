Return-Path: <rudhresh.jk@gmail.com>
Received: from mail-pd0-x22d.google.com (mail-pd0-x22d.google.com
 [IPv6:2607:f8b0:400e:c02::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6EE541A1D4D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 23:49:29 +1000 (AEST)
Received: by pdjr16 with SMTP id r16so53411055pdj.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 06:49:27 -0700 (PDT)
From: Rudhresh Kumar J <rudhresh.jk@gmail.com>
To: geoff@infradead.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rudhresh Kumar J <rudhresh.jk@gmail.com>
Subject: [PATCH] PS3: PS#-LPM: fixed a space coding style issue
Date: Mon, 27 Jul 2015 19:18:58 +0530
Message-Id: <1438004938-2280-1-git-send-email-rudhresh.jk@gmail.com>
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
1.8.4.5
