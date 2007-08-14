Return-Path: <bgill@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 926A0DDE3F
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 04:45:52 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l7EIjl4M002315
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Aug 2007 11:45:48 -0700 (MST)
From: Becky Bruce <becky.bruce@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Update lmb.h include protection to ASM_POWERPC
Date: Tue, 14 Aug 2007 13:45:44 -0500
Message-Id: <11871171442275-git-send-email-becky.bruce@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This file was protected by _PPC64_LMB_H, which is confusing, as the 32-bit code
also uses the lmb these days.  Changed to _ASM_POWERPC_LMB_H.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
---
 include/asm-powerpc/lmb.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-powerpc/lmb.h b/include/asm-powerpc/lmb.h
index 0c5880f..b5f9f4c 100644
--- a/include/asm-powerpc/lmb.h
+++ b/include/asm-powerpc/lmb.h
@@ -1,5 +1,5 @@
-#ifndef _PPC64_LMB_H
-#define _PPC64_LMB_H
+#ifndef _ASM_POWERPC_LMB_H
+#define _ASM_POWERPC_LMB_H
 #ifdef __KERNEL__
 
 /*
@@ -77,4 +77,4 @@ lmb_end_pfn(struct lmb_region *type, unsigned long region_nr)
 }
 
 #endif /* __KERNEL__ */
-#endif /* _PPC64_LMB_H */
+#endif /* _ASM_POWERPC_LMB_H */
-- 
1.5.0.3
