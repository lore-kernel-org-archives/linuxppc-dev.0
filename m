Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49CBF1A0174
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Oct 2014 14:47:30 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ulrich.weigand@de.ibm.com
Subject: [PATCH 2/3] powerpc: Remove double braces in alignment code.
Date: Fri, 31 Oct 2014 14:47:26 +1100
Message-Id: <1414727247-31838-2-git-send-email-anton@samba.org>
In-Reply-To: <1414727247-31838-1-git-send-email-anton@samba.org>
References: <1414727247-31838-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Looks like I introduced this when adding LE support.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/align.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index 34f5552..86150fb 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -908,7 +908,7 @@ int fix_alignment(struct pt_regs *regs)
 		flush_fp_to_thread(current);
 	}
 
-	if ((nb == 16)) {
+	if (nb == 16) {
 		if (flags & F) {
 			/* Special case for 16-byte FP loads and stores */
 			PPC_WARN_ALIGNMENT(fp_pair, regs);
-- 
1.9.1
