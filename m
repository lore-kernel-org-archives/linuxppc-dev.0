Return-Path: <kda@linux-powerpc.org>
Received: from mail-lb0-f175.google.com (mail-lb0-f175.google.com
 [209.85.217.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C4A8E1A072E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 05:03:10 +1100 (AEDT)
Received: by mail-lb0-f175.google.com with SMTP id n10so23467668lbv.6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Feb 2015 10:03:06 -0800 (PST)
From: Denis Kirjanov <kda@linux-powerpc.org>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 2/6] ppc: bpf: add required compatibility macros for
 jit
Date: Sun, 15 Feb 2015 21:06:41 +0300
Message-Id: <1424023605-2416-3-git-send-email-kda@linux-powerpc.org>
In-Reply-To: <1424023605-2416-1-git-send-email-kda@linux-powerpc.org>
References: <1424023605-2416-1-git-send-email-kda@linux-powerpc.org>
Cc: Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
---
 arch/powerpc/include/asm/asm-compat.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/include/asm/asm-compat.h b/arch/powerpc/include/asm/asm-compat.h
index 21be8ae..dc85dcb 100644
--- a/arch/powerpc/include/asm/asm-compat.h
+++ b/arch/powerpc/include/asm/asm-compat.h
@@ -23,6 +23,8 @@
 #define PPC_STL		stringify_in_c(std)
 #define PPC_STLU	stringify_in_c(stdu)
 #define PPC_LCMPI	stringify_in_c(cmpdi)
+#define PPC_LCMPLI	stringify_in_c(cmpldi)
+#define PPC_LCMP	stringify_in_c(cmpd)
 #define PPC_LONG	stringify_in_c(.llong)
 #define PPC_LONG_ALIGN	stringify_in_c(.balign 8)
 #define PPC_TLNEI	stringify_in_c(tdnei)
@@ -52,6 +54,8 @@
 #define PPC_STL		stringify_in_c(stw)
 #define PPC_STLU	stringify_in_c(stwu)
 #define PPC_LCMPI	stringify_in_c(cmpwi)
+#define PPC_LCMPLI	stringify_in_c(cmplwi)
+#define PPC_LCMP	stringify_in_c(cmpw)
 #define PPC_LONG	stringify_in_c(.long)
 #define PPC_LONG_ALIGN	stringify_in_c(.balign 4)
 #define PPC_TLNEI	stringify_in_c(twnei)
-- 
2.1.3
