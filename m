Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409V4M1YR9zF2CS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 23:02:11 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: mauricfo@linux.vnet.ibm.com
Subject: [PATCH v2 02/10] powerpc/pseries: Add new H_GET_CPU_CHARACTERISTICS
 flags
Date: Tue, 27 Mar 2018 23:01:45 +1100
Message-Id: <20180327120153.31612-2-mpe@ellerman.id.au>
In-Reply-To: <20180327120153.31612-1-mpe@ellerman.id.au>
References: <20180327120153.31612-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add some additional values which have been defined for the
H_GET_CPU_CHARACTERISTICS hypercall.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/hvcall.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index eca3f9c68907..5a740feb7bd7 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -337,6 +337,9 @@
 #define H_CPU_CHAR_L1D_FLUSH_ORI30	(1ull << 61) // IBM bit 2
 #define H_CPU_CHAR_L1D_FLUSH_TRIG2	(1ull << 60) // IBM bit 3
 #define H_CPU_CHAR_L1D_THREAD_PRIV	(1ull << 59) // IBM bit 4
+#define H_CPU_CHAR_BRANCH_HINTS_HONORED	(1ull << 58) // IBM bit 5
+#define H_CPU_CHAR_THREAD_RECONFIG_CTRL	(1ull << 57) // IBM bit 6
+#define H_CPU_CHAR_COUNT_CACHE_DISABLED	(1ull << 56) // IBM bit 7
 
 #define H_CPU_BEHAV_FAVOUR_SECURITY	(1ull << 63) // IBM bit 0
 #define H_CPU_BEHAV_L1D_FLUSH_PR	(1ull << 62) // IBM bit 1
-- 
2.14.1
