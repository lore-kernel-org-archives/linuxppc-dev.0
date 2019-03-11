Return-Path: <SRS0=/OnI=RO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E15CC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 20:21:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D578C2147C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 20:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D578C2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44J8dp6mc0zDqHS
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 07:21:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=212.227.126.133; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
X-Greylist: delayed 330 seconds by postgrey-1.36 at bilbo;
 Tue, 12 Mar 2019 00:49:59 AEDT
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Hzxg1nfdzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 00:49:58 +1100 (AEDT)
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N6Kl7-1h1Tiq0yT3-016gKR; Mon, 11 Mar 2019 14:44:01 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] sound: oao: Kconfig: pedantic formatting
Date: Mon, 11 Mar 2019 14:43:57 +0100
Message-Id: <1552311837-20110-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:igHL9q6apRXNbajmBme9+T+Z1B75qgAo3qK1ZpB7eGEdPgzwqH1
 gyEl4Hy7+t4GlDq4menqLpKLk3LqnlpQyT+r546i56BqbrwDVJOSh9mv7BOZYElnreJMRhk
 7/lV/Hc1gLEIWBEqVqNjPY9egSnm3CwF0zZ5Zu34yzk+xn6p58gpUULIGxkVDYGv0AOgcW7
 cwHddU4c9QlZCEQOgWd4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DI0xLUdYPlM=:5G8ajBdkCyQTjFqp07j9A8
 1jt/8JjXhBXTHGhoGPkpk9EeNDKGnZroNs2iGOw8TaMr1YcEjn+manUcgs+KYXPE/7Dg4GdNj
 UO94Thv8Sp+dYLBxWe92aMbEW8QlFQtVn0U2RMTHwphrinYLl0Y+TuHDb+7l2X7unpMUHsuUv
 dJUkdq6xYXnhYeSVLqS3/gp/jwWaSvMY7yDps6saTKia2U+v2k9y1NNwcgdNm+0bft4k54o43
 1+UHdKDSM0x+C5F6CG4i298Ab7ECf8+WBWVTjMucOautpwkkG0VJh7oksi1w9guTLTDLrNAAK
 Jj4y1iN9qyRHlF7Jcm0d2aB6uq1K2V3BNz6j1rG6+ke94/bzEbWwQ3lwn4D/EDt6SeD5hO+3S
 EhB6UUBgwjcpc96djEWpbguByBSsFtRYtWks6NAti56587haEzmNoyPzhEUwLVTkCWjxlRGmg
 6qbIb0HR2vdl+Mq4a8sq4FaY3aWmjRRsWN57F0ud/lfeuPkENDEBNm55e0Zj/ZRn83tiEIQvJ
 8xBRePEMjZytZJ01gZdnzgDZQPhQXINSATwwXnSe05eGTImcyn5oR1PoCUi40noncAPf6HxyA
 d59ToRLEGJNNwnY3fkVwRSyljpHlh7legNSVgWTQIJq/3g45DyftsOf6IOn0ZkdjLu9RsI9eF
 F75shIQgvRHKFoAlxuOFb5ikfevJywtup4RhEBLMFyzeEjMoVknKpBJ8PThkWD3sXzoDHmCq9
 YP1nywTiWx7m8uITNbcI0avZ5DU/pafkFxKXsw==
X-Mailman-Approved-At: Tue, 12 Mar 2019 07:18:57 +1100
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
Cc: johannes@sipsolutions.net, linuxppc-dev@lists.ozlabs.org, tiwai@suse.com,
 perex@perex.cz
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 sound/aoa/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/aoa/Kconfig b/sound/aoa/Kconfig
index c081e18..a1e3231 100644
--- a/sound/aoa/Kconfig
+++ b/sound/aoa/Kconfig
@@ -3,8 +3,8 @@ menuconfig SND_AOA
 	depends on PPC_PMAC
 	select SND_PCM
 	---help---
-	This option enables the new driver for the various
-	Apple Onboard Audio components.
+	  This option enables the new driver for the various
+	  Apple Onboard Audio components.
 
 if SND_AOA
 
@@ -14,4 +14,4 @@ source "sound/aoa/codecs/Kconfig"
 
 source "sound/aoa/soundbus/Kconfig"
 
-endif	# SND_AOA
+endif # SND_AOA
-- 
1.9.1

