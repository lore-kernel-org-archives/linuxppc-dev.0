Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 57967B6F62
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jun 2011 05:06:59 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p5SJ6sIC009565
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2011 14:06:54 -0500
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Whitespace fix to include/asm/pgtable-ppc64.h
Date: Tue, 28 Jun 2011 14:06:54 -0500
Message-Id: <1309288014309-git-send-email-beckyb@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Becky Bruce <beckyb@kernel.crashing.org>

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
 arch/powerpc/include/asm/pgtable-ppc64.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index 81576ee..c420561 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -357,7 +357,8 @@ void pgtable_cache_init(void);
 /*
  * find_linux_pte returns the address of a linux pte for a given
  * effective address and directory.  If not found, it returns zero.
- */static inline pte_t *find_linux_pte(pgd_t *pgdir, unsigned long ea)
+ */
+static inline pte_t *find_linux_pte(pgd_t *pgdir, unsigned long ea)
 {
 	pgd_t *pg;
 	pud_t *pu;
-- 
1.5.6.5
