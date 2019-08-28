Return-Path: <SRS0=F8gr=WY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFE5C3A5A1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 13:44:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9AA320828
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 13:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9AA320828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46JRmn2fZBzDqMx
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 23:44:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux-m68k.org
 (client-ip=2a02:1800:120:4::f00:d; helo=newton.telenet-ops.be;
 envelope-from=geert@linux-m68k.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=glider.be
X-Greylist: delayed 394 seconds by postgrey-1.36 at bilbo;
 Wed, 28 Aug 2019 23:41:00 AEST
Received: from newton.telenet-ops.be (newton.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46JRhr52XFzDqHP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2019 23:40:59 +1000 (AEST)
Received: from michel.telenet-ops.be (michel.telenet-ops.be
 [IPv6:2a02:1800:110:4::f00:18])
 by newton.telenet-ops.be (Postfix) with ESMTPS id 46JRY64kcmzMrGry
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2019 15:34:18 +0200 (CEST)
Received: from ramsan ([84.194.98.4]) by michel.telenet-ops.be with bizsmtp
 id udaG2000B05gfCL06daGz1; Wed, 28 Aug 2019 15:34:17 +0200
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1i2y5Y-0000C4-7e; Wed, 28 Aug 2019 15:34:16 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1i2y5Y-0005Ru-62; Wed, 28 Aug 2019 15:34:16 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: chenhui zhao <chenhui.zhao@freescale.com>, Scott Wood <oss@buserror.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/booke: Spelling s/date/data/
Date: Wed, 28 Aug 2019 15:34:15 +0200
Message-Id: <20190828133415.20903-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
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
 Geert Uytterhoeven <geert+renesas@glider.be>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Caching dates is never a good idea ;-)

Fixes: e7affb1dba0e9068 ("powerpc/cache: add cache flush operation for various e500")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/powerpc/kernel/cpu_setup_fsl_booke.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index 2b4f3ec0acf7d988..1d308780e0d31eb9 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -231,7 +231,7 @@ _GLOBAL(__setup_cpu_e5500)
 	blr
 #endif
 
-/* flush L1 date cache, it can apply to e500v2, e500mc and e5500 */
+/* flush L1 data cache, it can apply to e500v2, e500mc and e5500 */
 _GLOBAL(flush_dcache_L1)
 	mfmsr	r10
 	wrteei	0
-- 
2.17.1

