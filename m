Return-Path: <bgill@monty.am.freescale.net>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E0673DDF51
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jun 2008 09:19:10 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m5DNJ4S7003438
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 16:19:05 -0700 (MST)
Received: from monty.am.freescale.net (monty.am.freescale.net [10.82.19.26])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m5DNJ3uj016995
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 18:19:04 -0500 (CDT)
From: Becky Bruce <becky.bruce@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Silly spelling fix in pgtable-ppc32
Date: Fri, 13 Jun 2008 18:12:44 -0500
Message-Id: <1213398764-19605-1-git-send-email-becky.bruce@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
---
 include/asm-powerpc/pgtable-ppc32.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-powerpc/pgtable-ppc32.h b/include/asm-powerpc/pgtable-ppc32.h
index c08e714..dde466b 100644
--- a/include/asm-powerpc/pgtable-ppc32.h
+++ b/include/asm-powerpc/pgtable-ppc32.h
@@ -620,8 +620,8 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 }
 
 /*
- * 2.6 calles this without flushing the TLB entry, this is wrong
- * for our hash-based implementation, we fix that up here
+ * 2.6 calls this without flushing the TLB entry; this is wrong
+ * for our hash-based implementation, we fix that up here.
  */
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 static inline int __ptep_test_and_clear_young(unsigned int context, unsigned long addr, pte_t *ptep)
-- 
1.5.4.1
