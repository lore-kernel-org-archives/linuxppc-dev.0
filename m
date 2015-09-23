Return-Path: <bywxiaobai@163.com>
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
 by lists.ozlabs.org (Postfix) with ESMTP id B372F1A0205
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 00:00:43 +1000 (AEST)
From: Yaowei Bai <bywxiaobai@163.com>
To: perex@perex.cz, tiwai@suse.com, johannes@sipsolutions.net,
 k.kozlowski@samsung.com, elfring@users.sourceforge.net, fabf@skynet.be,
 lars@metafoo.de
Cc: linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 1/4] sound/onyx: remove redundant case entry
Date: Wed, 23 Sep 2015 21:58:28 +0800
Message-Id: <1443016711-5297-1-git-send-email-bywxiaobai@163.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Case ti->tag == 0 can be included in the last return,
remove it.

No functional change.

Signed-off-by: Yaowei Bai <bywxiaobai@163.com>
---
 sound/aoa/codecs/onyx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/aoa/codecs/onyx.c b/sound/aoa/codecs/onyx.c
index a04edff..a407e1f 100644
--- a/sound/aoa/codecs/onyx.c
+++ b/sound/aoa/codecs/onyx.c
@@ -683,7 +683,6 @@ static int onyx_usable(struct codec_info_item *cii,
 	mutex_unlock(&onyx->mutex);
 
 	switch (ti->tag) {
-	case 0: return 1;
 	case 1:	return analog_enabled;
 	case 2: return spdif_enabled;
 	}
-- 
1.9.1
