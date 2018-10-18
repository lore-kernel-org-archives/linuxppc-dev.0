Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86440C5ACCC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 05:26:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3642208E4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 05:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3642208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bHZk0S1LzF3SV
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 16:26:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bHVb6w82zF3T6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 16:22:31 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42bHVW2W36z9ttBQ;
 Thu, 18 Oct 2018 07:22:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id kUtr0N2kLCM7; Thu, 18 Oct 2018 07:22:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42bHVW22SPz9ttBP;
 Thu, 18 Oct 2018 07:22:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E6E2F8B781;
 Thu, 18 Oct 2018 07:22:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id XFTnMqXtgBlH; Thu, 18 Oct 2018 07:22:28 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B9D6A8B74C;
 Thu, 18 Oct 2018 07:22:28 +0200 (CEST)
Received: by pc13168vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 128E66F4C9; Thu, 18 Oct 2018 05:22:27 +0000 (UTC)
Message-Id: <458b3c101e9ab58d355b31ef6ca2632157023abb.1539804202.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/8xx: add missing header in 8xx_mmu.c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 18 Oct 2018 05:22:27 +0000 (UTC)
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
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

arch/powerpc/mm/8xx_mmu.c:174:6: error: no previous prototype for ‘set_context’ [-Werror=missing-prototypes]
 void set_context(unsigned long id, pgd_t *pgd)

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/8xx_mmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index 36484a2ef915..64ee7597380e 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/memblock.h>
+#include <linux/mmu_context.h>
 #include <asm/fixmap.h>
 #include <asm/code-patching.h>
 
-- 
2.13.3

