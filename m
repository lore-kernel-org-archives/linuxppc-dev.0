Return-Path: <kda@linux-powerpc.org>
Received: from mail-lb0-f169.google.com (mail-lb0-f169.google.com
 [209.85.217.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ECF151A0728
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 05:03:10 +1100 (AEDT)
Received: by mail-lb0-f169.google.com with SMTP id p9so23550875lbv.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Feb 2015 10:03:05 -0800 (PST)
From: Denis Kirjanov <kda@linux-powerpc.org>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 1/6] ppc: Kconfig: Enable BPF JIT on ppc32
Date: Sun, 15 Feb 2015 21:06:40 +0300
Message-Id: <1424023605-2416-2-git-send-email-kda@linux-powerpc.org>
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
 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 22b0940..5084bdc 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -126,7 +126,7 @@ config PPC
 	select IRQ_FORCED_THREADING
 	select HAVE_RCU_TABLE_FREE if SMP
 	select HAVE_SYSCALL_TRACEPOINTS
-	select HAVE_BPF_JIT if PPC64
+	select HAVE_BPF_JIT
 	select HAVE_ARCH_JUMP_LABEL
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_HAS_GCOV_PROFILE_ALL
-- 
2.1.3
