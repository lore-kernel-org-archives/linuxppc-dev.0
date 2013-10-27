Return-Path: <vaishnavi@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A5EAC2C00DE
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Oct 2013 17:17:40 +1100 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaishnavi@linux.vnet.ibm.com>;
 Sun, 27 Oct 2013 16:17:32 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B623B3578040
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Oct 2013 17:17:23 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9R604Aa32047358
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Oct 2013 17:00:05 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9R6HMa9009595
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Oct 2013 17:17:22 +1100
From: Vaishnavi Bhat <vaishnavi@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH TRIVIAL] powerpc: Fix a typo in comments of va to pa conversion
Date: Sun, 27 Oct 2013 11:47:19 +0530
Message-Id: <1382854639-11494-1-git-send-email-vaishnavi@linux.vnet.ibm.com>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes typo in comments virtual to physical
address conversion.

Signed-off-by: Vaishnavi Bhat <vaishnavi@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/page.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index b9f4262..753c662 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -78,7 +78,7 @@ extern unsigned int HPAGE_SHIFT;
  *
  * Also, KERNELBASE >= PAGE_OFFSET and PHYSICAL_START >= MEMORY_START
  *
- * There are two was to determine a physical address from a virtual one:
+ * There are two ways to determine a physical address from a virtual one:
  * va = pa + PAGE_OFFSET - MEMORY_START
  * va = pa + KERNELBASE - PHYSICAL_START
  *
-- 
1.7.9.5
