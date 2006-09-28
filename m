Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 0CFB1679E0
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 14:58:01 +1000 (EST)
Date: Wed, 27 Sep 2006 23:57:17 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org, galak@kernel.crashing.org, Vitaly Bordug
	<vbordug@ru.mvista.com>
Subject: [PATCH] ppc: fix build break
Message-ID: <20060927235717.40cbd0e7@pb15>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix build break for some of the ARCH=ppc defconfigs

Signed-off-by: Olof Johansson <olof@lixom.net>


---

This was introduced by:

[PATCH] ppc32: board-specific part of fs_enet update


Index: linux-2.6/include/asm-ppc/cpm2.h
===================================================================
--- linux-2.6.orig/include/asm-ppc/cpm2.h
+++ linux-2.6/include/asm-ppc/cpm2.h
@@ -1186,7 +1186,7 @@ typedef struct im_idma {
 #define FCC_MEM_OFFSET(x) (CPM_FCC_SPECIAL_BASE + (x*128))
 #define FCC1_MEM_OFFSET FCC_MEM_OFFSET(0)
 #define FCC2_MEM_OFFSET FCC_MEM_OFFSET(1)
-#define FCC2_MEM_OFFSET FCC_MEM_OFFSET(2)
+#define FCC3_MEM_OFFSET FCC_MEM_OFFSET(2)
 
 #endif /* __CPM2__ */
 #endif /* __KERNEL__ */
