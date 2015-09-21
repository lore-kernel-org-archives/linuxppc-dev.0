Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D6ABB1A0144
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:35 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 21 Sep 2015 16:42:35 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D12542CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:32 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8L6gOoa30736394
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:32 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8L6fxAu014793
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:00 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 14/31] powerpc/booke: Move booke headers (part 2)
Date: Mon, 21 Sep 2015 12:10:41 +0530
Message-Id: <1442817658-2588-15-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/{pgtable-ppc32.h => booke/32/pgtable.h} | 0
 arch/powerpc/include/asm/{pgtable-ppc64.h => booke/64/pgtable.h} | 0
 arch/powerpc/include/asm/booke/pgtable.h                         | 8 ++++----
 3 files changed, 4 insertions(+), 4 deletions(-)
 rename arch/powerpc/include/asm/{pgtable-ppc32.h => booke/32/pgtable.h} (100%)
 rename arch/powerpc/include/asm/{pgtable-ppc64.h => booke/64/pgtable.h} (100%)

diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/include/asm/booke/32/pgtable.h
similarity index 100%
rename from arch/powerpc/include/asm/pgtable-ppc32.h
rename to arch/powerpc/include/asm/booke/32/pgtable.h
diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/booke/64/pgtable.h
similarity index 100%
rename from arch/powerpc/include/asm/pgtable-ppc64.h
rename to arch/powerpc/include/asm/booke/64/pgtable.h
diff --git a/arch/powerpc/include/asm/booke/pgtable.h b/arch/powerpc/include/asm/booke/pgtable.h
index 20451f03df8f..8d2fa3e9c7af 100644
--- a/arch/powerpc/include/asm/booke/pgtable.h
+++ b/arch/powerpc/include/asm/booke/pgtable.h
@@ -1,10 +1,10 @@
-#ifndef _ASM_POWERPC_PGTABLE_BOOK3E_H
-#define _ASM_POWERPC_PGTABLE_BOOK3E_H
+#ifndef _ASM_POWERPC_BOOKE_PGTABLE_H
+#define _ASM_POWERPC_BOOKE_PGTABLE_H
 
 #if defined(CONFIG_PPC64)
-#include <asm/pgtable-ppc64.h>
+#include <asm/booke/64/pgtable.h>
 #else
-#include <asm/pgtable-ppc32.h>
+#include <asm/booke/32/pgtable.h>
 #endif
 
 #ifndef __ASSEMBLY__
-- 
2.5.0
