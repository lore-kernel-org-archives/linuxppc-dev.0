Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E469FC0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 14:01:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D15A2085B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 14:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D15A2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qp4K3Y2jzF3Jt
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 01:01:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux-m68k.org
 (client-ip=195.130.137.77; helo=leibniz.telenet-ops.be;
 envelope-from=geert@linux-m68k.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=glider.be
X-Greylist: delayed 609 seconds by postgrey-1.36 at bilbo;
 Thu, 08 Nov 2018 00:59:22 AEDT
Received: from leibniz.telenet-ops.be (leibniz.telenet-ops.be [195.130.137.77])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qp1k2GlszF3Hg
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Nov 2018 00:59:21 +1100 (AEDT)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be
 [IPv6:2a02:1800:110:4::f00:19])
 by leibniz.telenet-ops.be (Postfix) with ESMTPS id 42qnnv309MzMqwkw
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Nov 2018 14:49:07 +0100 (CET)
Received: from ramsan.of.borg ([84.194.111.163])
 by laurent.telenet-ops.be with bizsmtp
 id x1p41y00e3XaVaC011p4SS; Wed, 07 Nov 2018 14:49:06 +0100
Received: from rox.of.borg ([192.168.97.57])
 by ramsan.of.borg with esmtp (Exim 4.86_2)
 (envelope-from <geert@linux-m68k.org>)
 id 1gKOCe-0005EJ-Qc; Wed, 07 Nov 2018 14:49:04 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1gKOCe-0003lq-OG; Wed, 07 Nov 2018 14:49:04 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Jiri Kosina <trivial@kernel.org>
Subject: [PATCH trivial] powerpc: Typo s/use use/use/
Date: Wed,  7 Nov 2018 14:49:03 +0100
Message-Id: <20181107134903.14453-1-geert+renesas@glider.be>
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
Cc: linuxppc-dev@lists.ozlabs.org, Geert Uytterhoeven <geert+renesas@glider.be>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/powerpc/include/asm/nohash/32/pte-40x.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pte-40x.h b/arch/powerpc/include/asm/nohash/32/pte-40x.h
index 661f4599f2fc54a7..12c6811e344bc5ea 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-40x.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-40x.h
@@ -33,7 +33,7 @@
  *   is cleared in the TLB miss handler before the TLB entry is loaded.
  * - All other bits of the PTE are loaded into TLBLO without
  *   modification, leaving us only the bits 20, 21, 24, 25, 26, 30 for
- *   software PTE bits.  We actually use use bits 21, 24, 25, and
+ *   software PTE bits.  We actually use bits 21, 24, 25, and
  *   30 respectively for the software bits: ACCESSED, DIRTY, RW, and
  *   PRESENT.
  */
-- 
2.17.1

