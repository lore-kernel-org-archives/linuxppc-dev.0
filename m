Return-Path: <SRS0=rclJ=QA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60090C433F5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Nov 2021 04:42:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BD2961077
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Nov 2021 04:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8BD2961077
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cdjrlc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HrjVs4KGHz3c9T
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Nov 2021 15:42:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=cdjrlc.com (client-ip=59.36.128.82; helo=smtpbg604.qq.com;
 envelope-from=wangborong@cdjrlc.com; receiver=<UNKNOWN>)
X-Greylist: delayed 66 seconds by postgrey-1.36 at boromir;
 Sat, 13 Nov 2021 15:42:15 AEDT
Received: from smtpbg604.qq.com (smtpbg604.qq.com [59.36.128.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HrjVH2Kr8z2xsj
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Nov 2021 15:42:14 +1100 (AEDT)
X-QQ-mid: bizesmtp41t1636778421tkvo9okg
Received: from localhost.localdomain (unknown [125.69.41.88])
 by esmtp6.qq.com (ESMTP) with 
 id ; Sat, 13 Nov 2021 12:40:20 +0800 (CST)
X-QQ-SSF: 01000000000000C0F000C00A0000000
X-QQ-FEAT: FXvDfBZI5O4ZPSh7w95J4xYXfclSDsGXKPecStb0FuWMtQfjyoscsC5z5WinO
 umbYfA61YWKdGgpiBBmiedBniwB+lCgl8na3yUuzDGhVjcOy4GA9JFfRKO/Y5WBc/ODX9pb
 XJuHfcCAEpyRoBZl4GgUqWphQKOwwtQYi56K6hzis3TEGy3x7ta9TSnnmIP1uYI61j71WVw
 Vw8ql8us1UXgRMeWxRUGXsXfKkjOc5P0SH2GmWomPzN+1/Wdaio8eSnv2FYIj/TIwGru1f3
 qoFBTDJqRJqxeXEajHfrpoxYprzUQOH1HOlH/8o7QM/K6A4iH5bp9SLvZYVmLckDD0leYmd
 zG/4UV7wbUuqmP1PSiSfazf9D7jmdQGgj8oU1Wy
X-QQ-GoodBg: 0
From: Jason Wang <wangborong@cdjrlc.com>
To: benh@kernel.crashing.org
Subject: [PATCH] mm: Remove a repeated word in a comment
Date: Sat, 13 Nov 2021 12:40:18 +0800
Message-Id: <20211113044018.130835-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam4
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 wangborong@cdjrlc.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The double word `up' in a comment is repeated, thus one of
them should be removed.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/macintosh/mediabay.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/macintosh/mediabay.c b/drivers/macintosh/mediabay.c
index eab7e83c11c4..ec23094263e7 100644
--- a/drivers/macintosh/mediabay.c
+++ b/drivers/macintosh/mediabay.c
@@ -129,7 +129,7 @@ enum {
 /*
  * Functions for polling content of media bay
  */
- 
+
 static u8
 ohare_mb_content(struct media_bay_info *bay)
 {
@@ -331,12 +331,12 @@ static void keylargo_mb_un_reset_ide(struct media_bay_info* bay)
 
 static inline void set_mb_power(struct media_bay_info* bay, int onoff)
 {
-	/* Power up up and assert the bay reset line */
+	/* Power up and assert the bay reset line */
 	if (onoff) {
 		bay->ops->power(bay, 1);
 		bay->state = mb_powering_up;
 		pr_debug("mediabay%d: powering up\n", bay->index);
-	} else { 
+	} else {
 		/* Make sure everything is powered down & disabled */
 		bay->ops->power(bay, 0);
 		bay->state = mb_powering_down;
@@ -577,7 +577,7 @@ static int media_bay_attach(struct macio_dev *mdev,
 		macio_release_resources(mdev);
 		return -ENOMEM;
 	}
-	
+
 	i = media_bay_count++;
 	bay = &media_bays[i];
 	bay->mdev = mdev;
@@ -745,7 +745,7 @@ static int __init media_bay_init(void)
 	if (!machine_is(powermac))
 		return 0;
 
-	macio_register_driver(&media_bay_driver);	
+	macio_register_driver(&media_bay_driver);
 
 	return 0;
 }
-- 
2.33.0

