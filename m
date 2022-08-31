Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B71FECAAD4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Aug 2022 00:51:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MHQcC48RJz3cBK
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Aug 2022 10:51:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cdjrlc.com (client-ip=43.155.67.158; helo=bg4.exmail.qq.com; envelope-from=yuanjilin@cdjrlc.com; receiver=<UNKNOWN>)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MHQbl5dr6z2xJJ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2022 10:51:31 +1000 (AEST)
X-QQ-mid: bizesmtp65t1661907076t71dp7kp
Received: from localhost.localdomain ( [182.148.13.26])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 31 Aug 2022 08:51:15 +0800 (CST)
X-QQ-SSF: 01000000000000D0E000000A0000000
X-QQ-FEAT: +Fw3Sd5mYDV3NXJYi2PUaOKmNOiSsq1mENG/uF0kFpWPZnXyZd8lJOxo46/7Y
	z37j57He1ZFbyt74DzNB1W2ltcRgdFyte9VG+z+Mupni0VYUrY3iHxnjp62bMZkbahC00Uw
	qy7T/E/rVtxE5ZvbXz9Hdsev+hhbzUUq8Q7LPFy8P3In4MbYVGQ/wj+VbgiDE+Zh/ZcadSq
	d5Xgq1UG3C/YhqnE2P0PXnxQ0/vv1atGJxHW7TzGEl3Mrlql2cp5ZfotzL3A/nYDBW1HkaX
	2LIUE+6DZSR2Yy5Kyg52YYjyqApFZPaBQ0UUNOK4t2VC8oDoKZQ75vkmhL0qPTcUCA2tmIz
	MEdIjtOG5paTN9jMvIBLBWTDjawtF9M9DwNB8hcscKfYfSWKSI=
X-QQ-GoodBg: 0
From: Jilin Yuan <yuanjilin@cdjrlc.com>
To: mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu
Subject: [PATCH] powerpc/mobility: fix repeated words in comments
Date: Wed, 31 Aug 2022 08:51:09 +0800
Message-Id: <20220831005109.38314-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
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
Cc: Jilin Yuan <yuanjilin@cdjrlc.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 arch/powerpc/platforms/pseries/mobility.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 3d36a8955eaf..c92c78332303 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -216,7 +216,7 @@ static int update_dt_node(struct device_node *dn, s32 scope)
 		nprops = be32_to_cpu(upwa->nprops);
 
 		/* On the first call to ibm,update-properties for a node the
-		 * the first property value descriptor contains an empty
+		 * first property value descriptor contains an empty
 		 * property name, the property value length encoded as u32,
 		 * and the property value is the node path being updated.
 		 */
-- 
2.36.1

