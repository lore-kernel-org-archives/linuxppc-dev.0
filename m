Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11456EB64DA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Jul 2023 09:38:31 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="unknown key version" header.d=208.org header.i=@208.org header.a=rsa-sha256 header.s=dkim header.b=p/Tb6cCj;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R4v5d4cWQz3bX1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Jul 2023 19:38:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="unknown key version" header.d=208.org header.i=@208.org header.a=rsa-sha256 header.s=dkim header.b=p/Tb6cCj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=208suo.com (client-ip=183.242.55.162; helo=mail.208.org; envelope-from=hanyu001@208suo.com; receiver=lists.ozlabs.org)
Received: from mail.208.org (unknown [183.242.55.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R4v4h2Qf6z2yt6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2023 19:37:40 +1000 (AEST)
Received: from mail.208.org (email.208.org [127.0.0.1])
	by mail.208.org (Postfix) with ESMTP id 4R4v4c1THqzBR1PG
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2023 17:37:36 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
	content-transfer-encoding:content-type:message-id:user-agent
	:references:in-reply-to:subject:to:from:date:mime-version; s=
	dkim; t=1689673055; x=1692265056; bh=6zOPQz80Mv/HWERPJeIchOiif9I
	O5sqEE8rXdj84adc=; b=p/Tb6cCj2ZdphLNkvYWO15gt6el6IQdTLxKV+lvlNNM
	iDR0zw2mpwuvnRaIPNcGqBU/CYPgyb6hfLRJm9QjkApvivu22q/d1dnhHASY2GHC
	jVWpPaq0SC0dzm+Q1l/ZlOBs3naNpOATFHA9VjQArMgbXnEq2ixiHg3EUW1agmY7
	2pokM9+105WlvQx9tRV9s234AgvL01lc2DjcjyKrd3UhxnTj6KzvEepSUlD8avzN
	f2eaCkMTO7vEZtV1UFdM0o7+uw1LnZgaUBy700YsSkQzt/FvW/+pVy3N8vGbWAvc
	waMBVVhlCJx8yuFJUfC1Giuse5UKhMsTXkBUiQrF62Q==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
	by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7ObkDoK8iCHx for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Jul 2023 17:37:35 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
	by mail.208.org (Postfix) with ESMTPSA id 4R4v4b3dVlzBJBfd;
	Tue, 18 Jul 2023 17:37:35 +0800 (CST)
MIME-Version: 1.0
Date: Tue, 18 Jul 2023 17:37:35 +0800
From: hanyu001@208suo.com
To: benh@kernel.crashing.org, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, robh@kernel.org, axboe@kernel.dk,
 chenlifu@huawei.com
Subject: [PATCH] platforms: powermac: insert space before the open parenthesis
 '('
In-Reply-To: <tencent_3EB579E7E40217D5639568E3324407B49E08@qq.com>
References: <tencent_3EB579E7E40217D5639568E3324407B49E08@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <0941033d34b2403020f9e4cc17765381@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Fixes checkpatch error:

/powerpc/platforms/powermac/setup.c:222:ERROR: space required before the 
open parenthesis '('

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  arch/powerpc/platforms/powermac/setup.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/setup.c 
b/arch/powerpc/platforms/powermac/setup.c
index 0c41f4b005bc..a89f3022f3a8 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -219,7 +219,7 @@ static void __init ohare_init(void)
                  sysctrl_regs[4] |= 0x04000020;
              else
                  sysctrl_regs[4] |= 0x04000000;
-            if(has_l2cache)
+            if (has_l2cache)
                  printk(KERN_INFO "Level 2 cache enabled\n");
          }
      }
