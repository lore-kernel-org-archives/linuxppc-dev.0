Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475E8EB64DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Jul 2023 08:50:23 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="unknown key version" header.d=208.org header.i=@208.org header.a=rsa-sha256 header.s=dkim header.b=XDrL0lOk;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R5Tzd4J6cz3bWn
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Jul 2023 18:50:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="unknown key version" header.d=208.org header.i=@208.org header.a=rsa-sha256 header.s=dkim header.b=XDrL0lOk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=208suo.com (client-ip=183.242.55.162; helo=mail.208.org; envelope-from=hanyu001@208suo.com; receiver=lists.ozlabs.org)
Received: from mail.208.org (unknown [183.242.55.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R5Tyg2JXTz2ypx
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2023 18:49:30 +1000 (AEST)
Received: from mail.208.org (email.208.org [127.0.0.1])
	by mail.208.org (Postfix) with ESMTP id 4R5TyL5sSdzBHYMG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2023 16:49:14 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
	content-transfer-encoding:content-type:message-id:user-agent
	:references:in-reply-to:subject:to:from:date:mime-version; s=
	dkim; t=1689756554; x=1692348555; bh=5pj+9SB9XL67KdC10MygRAqL6Th
	a9QqQRVIGmyiPYck=; b=XDrL0lOkiruk2A4pSWjZQt171qgTQDWtCO4rpNisxeL
	/JON7vGQvw3kGbumw9O5cR3pTSJdRfMTe2aj3ooPqAWbmfwFU2xrsP2kL2OfqKAG
	XQANlwCWi6vr1Kjvu/ZvHsADhepAioDGOnCQyPGgPzByrnxbjjExUBgmI/cBZ2P2
	6Ebyvt5P43rENidmG8RHctHIN2kC4G1ZryJOZq3arC0A+zteUHqyJNkkdFIuBLs/
	ShTq4NK35WOWCUmGnDoXQP72XdwCMo+PUdKgqgHpCNBx6vUp36qPAu96T5yczcdx
	ukdHaZEi4xJk+YmqRboI8xwLkEgC0qYcTKyx8966wKw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
	by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ppgVHkZWVax9 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Jul 2023 16:49:14 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
	by mail.208.org (Postfix) with ESMTPSA id 4R5TyL4PZHzBHXhP;
	Wed, 19 Jul 2023 16:49:14 +0800 (CST)
MIME-Version: 1.0
Date: Wed, 19 Jul 2023 16:49:14 +0800
From: hanyu001@208suo.com
To: benh@kernel.crashing.org, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu
Subject: [PATCH] platforms: powermac: Add require space after that ','
In-Reply-To: <tencent_D88DA71125D0DAD5369DE30A8055B355A20A@qq.com>
References: <tencent_D88DA71125D0DAD5369DE30A8055B355A20A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <96c612b1e07dfde74413322609dfc4fe@208suo.com>
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

Fix below checkpatch errors:

platforms/powermac/pfunc_core.c:22: ERROR: space required after that ',' 
(ctx:VxV)
platforms/powermac/pfunc_core.c:22: ERROR: space required after that ',' 
(ctx:VxV)

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  arch/powerpc/platforms/powermac/pfunc_core.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/pfunc_core.c 
b/arch/powerpc/platforms/powermac/pfunc_core.c
index 22741ddfd5b2..07555c1bb484 100644
--- a/arch/powerpc/platforms/powermac/pfunc_core.c
+++ b/arch/powerpc/platforms/powermac/pfunc_core.c
@@ -19,7 +19,7 @@
  /* Debug */
  #define LOG_PARSE(fmt...)
  #define LOG_ERROR(fmt...)    printk(fmt)
-#define LOG_BLOB(t,b,c)
+#define LOG_BLOB(t, b, c)

  #undef DEBUG
  #ifdef DEBUG
