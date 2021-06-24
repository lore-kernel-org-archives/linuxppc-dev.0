Return-Path: <SRS0=UTIz=LS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E77C48BDF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jun 2021 06:57:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12F0261374
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jun 2021 06:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F0261374
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G9WDL440rz3bxQ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jun 2021 16:57:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=BMYUamZ0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=163.com
 (client-ip=220.181.12.16; helo=m12-16.163.com;
 envelope-from=13145886936@163.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=BMYUamZ0; dkim-atps=neutral
X-Greylist: delayed 920 seconds by postgrey-1.36 at boromir;
 Thu, 24 Jun 2021 16:19:07 AEST
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
 by lists.ozlabs.org (Postfix) with ESMTP id 4G9VMb2NWCz2yxj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jun 2021 16:19:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hmqpo
 rXhZUOVVVEf/ac1YPbTWg/x3HX0KGoPZSyn+fI=; b=BMYUamZ0sV7zSAvreJrE5
 tnWBbLM8GzSl01Gd3ztUBu9gBlR0ju1fM7MQMMBB4/NWaIS1CBtfWPtZ5dN+U1ZS
 5jTXPNNE+a5NdxGavoXVq/6OgXcZxSysTEsVuD/7p8bn47nQCcfcqDLC/X88ctKu
 iCegbeU4p3T2nn0faOFTBo=
Received: from ubuntu.localdomain (unknown [218.17.89.92])
 by smtp12 (Coremail) with SMTP id EMCowAA3U08qINRg8uHZyw--.39766S2;
 Thu, 24 Jun 2021 14:03:22 +0800 (CST)
From: 13145886936@163.com
To: geoff@infradead.org
Subject: [PATCH] powerpc: ps3: remove unneeded semicolon
Date: Wed, 23 Jun 2021 23:03:16 -0700
Message-Id: <20210624060316.25734-1-13145886936@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowAA3U08qINRg8uHZyw--.39766S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF1UtF4ftryrXF45Gw4DArb_yoWfuwc_Aw
 4Iv3Z7uFW8Jr12k3Z7CFn7Wr17J3sIgrWYgrsFq3W3t345J3yF9395JFWUGw4UXF92yrZx
 AFn8J3sxAa4SyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU55Ma5UUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5zrdx5xxdq6xppld0qqrwthudrp/xtbBdgq7g1UMRXtdgwAAs9
X-Mailman-Approved-At: Thu, 24 Jun 2021 16:57:30 +1000
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
 gushengxian <gushengxian@yulong.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: gushengxian <gushengxian@yulong.com>

Remove unneeded semocolons.

Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 arch/powerpc/platforms/ps3/system-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
index 1a5665875165..f57f37fe038c 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -604,7 +604,7 @@ static dma_addr_t ps3_ioc0_map_page(struct device *_dev, struct page *page,
 	default:
 		/* not happned */
 		BUG();
-	};
+	}
 	result = ps3_dma_map(dev->d_region, (unsigned long)ptr, size,
 			     &bus_addr, iopte_flag);
 
@@ -763,7 +763,7 @@ int ps3_system_bus_device_register(struct ps3_system_bus_device *dev)
 		break;
 	default:
 		BUG();
-	};
+	}
 
 	dev->core.of_node = NULL;
 	set_dev_node(&dev->core, 0);
-- 
2.25.1


