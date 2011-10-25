Return-Path: <B29882@freescale.com>
Received: from VA3EHSOBE003.bigfish.com (va3ehsobe003.messaging.microsoft.com
 [216.32.180.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id D80E41007D9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2011 09:54:13 +1100 (EST)
Received: from mail8-va3 (localhost [127.0.0.1])	by mail8-va3-R.bigfish.com
 (Postfix) with ESMTP id 12C374800D4	for <linuxppc-dev@lists.ozlabs.org>; Tue,
 25 Oct 2011 22:54:05 +0000 (UTC)
Received: from VA3EHSMHS007.bigfish.com (unknown [10.7.14.235])	by
 mail8-va3.bigfish.com (Postfix) with ESMTP id ACB02180052	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2011 22:54:04 +0000 (UTC)
From: Matthew McClintock <msm@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <kumar.gala@freescale.com>
Subject: [PATCH 2/5] powerpc/fsl_booke: Fix comment in head_fsl_booke.S
Date: Tue, 25 Oct 2011 17:54:03 -0500
Message-ID: <1319583246-6120-2-git-send-email-msm@freescale.com>
In-Reply-To: <1319583246-6120-1-git-send-email-msm@freescale.com>
References: <1319583246-6120-1-git-send-email-msm@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix typo in comments introduced by:

commit 6dece0eb69b2a28e18d104bc5d707f1cb673f5e0
Author: Scott Wood <scottwood@freescale.com>
Date:   Mon Jul 25 11:29:33 2011 +0000

    powerpc/32: Pass device tree address as u64 to machine_init

Signed-off-by: Matthew McClintock <msm@freescale.com>
cc: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/head_fsl_booke.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index e1c699f..9f5d210 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -80,8 +80,8 @@ _ENTRY(_start);
 	slw	r18,r18,r17		/* r18 = page size */
 	addi	r18,r18,-1
 	and	r19,r3,r18		/* r19 = page offset */
-	andc	r31,r20,r18		/* r3 = page base */
-	or	r31,r31,r19		/* r3 = devtree phys addr */
+	andc	r31,r20,r18		/* r31 = page base */
+	or	r31,r31,r19		/* r31 = devtree phys addr */
 	mfspr	r30,SPRN_MAS7
 
 	li	r25,0			/* phys kernel start (low) */
-- 
1.7.6.1
