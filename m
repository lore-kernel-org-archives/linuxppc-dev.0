Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB81FC433EF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jun 2022 22:59:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LTbKm2KJbz3fCM
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jun 2022 08:59:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cdjrlc.com (client-ip=106.55.201.188; helo=smtpbg.qq.com; envelope-from=jiangjian@cdjrlc.com; receiver=<UNKNOWN>)
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LTGkM0jl5z2xKX
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2022 20:30:52 +1000 (AEST)
X-QQ-mid: bizesmtp87t1655980220tgs2spg2
Received: from ubuntu.localdomain ( [106.117.99.68])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Jun 2022 18:30:16 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000D00A0000000
X-QQ-FEAT: 0Eq+cbWb7RykbQkz594CL+OpPtXFI9VBWbjLZ64okZcXuAB/mi7dxZAF7eoEn
	tLLwY+kL6rR/yFGZGWFJETTpzPIzQiD3nDN+6LQtI+T2r/txxC1MCXkI9vBapvFiIcsgWkT
	TcN/ycOzUO4InStyt73dsMjHWik8Qtwv5vKUaJdQFDISKi3qE4MVc1CiTUuRwIs3ENJ6vNz
	rjHnlfTDWj0jTPQJp7Ow7WErE3HlA2io+NdubIgQMm/M69dO0TYgd3g23r7uM7n89tuMS2V
	yY4e8FJ2WQpHekopUtiAyiRp2RVDL2MnsCJntz4dBB09iKsF5xDbilLtIE2wqayFo/1JDM7
	skQMpj7a1UgjsUTc4wbAqepsdvAyAMm7izKvtax
X-QQ-GoodBg: 0
From: Jiang Jian <jiangjian@cdjrlc.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net
Subject: [PATCH] crypto: vmx - drop unexpected word 'for' in comments
Date: Thu, 23 Jun 2022 18:30:14 +0800
Message-Id: <20220623103014.41269-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Mailman-Approved-At: Fri, 24 Jun 2022 08:56:56 +1000
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
Cc: nayna@linux.ibm.com, linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>, pfsmorigo@gmail.com, linux-crypto@vger.kernel.org, leitao@debian.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

there is an unexpected word 'for' in the comments that need to be dropped

file - drivers/crypto/vmx/ghashp8-ppc.pl
line - 19

"# GHASH for for PowerISA v2.07."

changed to:

"# GHASH for PowerISA v2.07."

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/crypto/vmx/ghashp8-ppc.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/vmx/ghashp8-ppc.pl b/drivers/crypto/vmx/ghashp8-ppc.pl
index 09bba1852eec..041e633c214f 100644
--- a/drivers/crypto/vmx/ghashp8-ppc.pl
+++ b/drivers/crypto/vmx/ghashp8-ppc.pl
@@ -16,7 +16,7 @@
 # details see https://www.openssl.org/~appro/cryptogams/.
 # ====================================================================
 #
-# GHASH for for PowerISA v2.07.
+# GHASH for PowerISA v2.07.
 #
 # July 2014
 #
-- 
2.17.1

