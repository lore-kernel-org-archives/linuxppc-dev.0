Return-Path: <haren@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A7BB72C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 17:52:20 +1100 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Wed, 31 Oct 2012 00:52:18 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 380D01FF003F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 00:52:15 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q9V6qGts238176
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 00:52:16 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q9V6qGHJ029114
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 00:52:16 -0600
Subject: [PATCH 2/6] powerpc: Define CPU_FTR_HAS_PPR
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, anton@au1.ibm.com,
 mikey@neuling.org
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 30 Oct 2012 23:52:14 -0700
Message-ID: <1351666334.32304.13.camel@hbabu-laptop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[PATCH 2/6] powerpc: Define CPU_FTR_HAS_PPR

CPU_FTR_HAS_PPR is defined for POWER7.

Signed-off-by: Haren Myneni <haren@us.ibm.com>
---
 arch/powerpc/include/asm/cputable.h |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 21a0687..12e3a1d 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -171,6 +171,7 @@ extern const char *powerpc_base_platform;
 #define CPU_FTR_POPCNTD			LONG_ASM_CONST(0x0800000000000000)
 #define CPU_FTR_ICSWX			LONG_ASM_CONST(0x1000000000000000)
 #define CPU_FTR_VMX_COPY		LONG_ASM_CONST(0x2000000000000000)
+#define	CPU_FTR_HAS_PPR			LONG_ASM_CONST(0x4000000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -400,7 +401,8 @@ extern const char *powerpc_base_platform;
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
 	    CPU_FTR_DSCR | CPU_FTR_SAO  | CPU_FTR_ASYM_SMT | \
 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
-	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY)
+	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | \
+	    CPU_FTR_VMX_COPY | CPU_FTR_HAS_PPR)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
@@ -422,7 +424,7 @@ extern const char *powerpc_base_platform;
 	    (CPU_FTRS_POWER3 | CPU_FTRS_RS64 | CPU_FTRS_POWER4 |	\
 	    CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | CPU_FTRS_POWER6 |	\
 	    CPU_FTRS_POWER7 | CPU_FTRS_CELL | CPU_FTRS_PA6T |		\
-	    CPU_FTR_VSX)
+	    CPU_FTR_VSX | CPU_FTR_HAS_PPR)
 #endif
 #else
 enum {
-- 
1.7.1
