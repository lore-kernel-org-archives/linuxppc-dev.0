Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A37572C00C1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2013 21:00:13 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/booke: remove obsolete macro FINISH_EXCEPTION
Date: Mon, 29 Apr 2013 18:59:57 +0800
Message-ID: <1367233197-16167-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is stale and not used by anyone now.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
This passed the build test with the ppc44x_defconfig, corenet32_smp_defconfig.

 arch/powerpc/kernel/head_booke.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index 5f051ee..b385350 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -199,11 +199,6 @@
         .align 5;              						     \
 label:
 
-#define FINISH_EXCEPTION(func)					\
-	bl	transfer_to_handler_full;			\
-	.long	func;						\
-	.long	ret_from_except_full
-
 #define EXCEPTION(n, intno, label, hdlr, xfer)			\
 	START_EXCEPTION(label);					\
 	NORMAL_EXCEPTION_PROLOG(intno);				\
-- 
1.8.1.4
