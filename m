Return-Path: <SRS0=GbMY=KQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE1EC433ED
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 May 2021 02:56:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7519611AE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 May 2021 02:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7519611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FmWTC2Z4Kz3bv3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 May 2021 12:56:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.35; helo=szxga07-in.huawei.com;
 envelope-from=tanxiaofei@huawei.com; receiver=<UNKNOWN>)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FmWSn4W1Kz2yXs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 May 2021 12:55:49 +1000 (AEST)
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.60])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FmWPM2c6GzBvQC;
 Fri, 21 May 2021 10:52:55 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 10:55:42 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 10:55:42 +0800
From: Xiaofei Tan <tanxiaofei@huawei.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
Subject: [PATCH RESEND] tty: hvc_console: Remove the repeated words 'no' and
 'from'
Date: Fri, 21 May 2021 10:52:38 +0800
Message-ID: <1621565558-26118-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
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
Cc: Xiaofei Tan <tanxiaofei@huawei.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Remove the repeated words 'no' and 'from', reported by checkpatch.pl.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/tty/hvc/hvc_console.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index cdcc64e..bdd8d2b 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -292,7 +292,7 @@ int hvc_instantiate(uint32_t vtermno, int index, const struct hv_ops *ops)
 	if (vtermnos[index] != -1)
 		return -1;
 
-	/* make sure no no tty has been registered in this index */
+	/* make sure no tty has been registered in this index */
 	hp = hvc_get_by_index(index);
 	if (hp) {
 		tty_port_put(&hp->port);
@@ -620,7 +620,7 @@ static u32 timeout = MIN_TIMEOUT;
 /*
  * Maximum number of bytes to get from the console driver if hvc_poll is
  * called from driver (and can't sleep). Any more than this and we break
- * and start polling with khvcd. This value was derived from from an OpenBMC
+ * and start polling with khvcd. This value was derived from an OpenBMC
  * console with the OPAL driver that results in about 0.25ms interrupts off
  * latency.
  */
-- 
2.8.1

