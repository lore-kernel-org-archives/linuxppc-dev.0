Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 63C551A199A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 17:47:33 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Wed, 1 Oct 2014 01:47:31 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 8476F19D803D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 01:36:13 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s917lSlY50397288
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 09:47:28 +0200
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s917q3Yx008276
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 01:52:03 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] powerpc: Adding macro for accessing Thread Switch
 Control Register
Date: Wed,  1 Oct 2014 13:16:54 +0530
Message-Id: <1412149617-3178-3-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1412149617-3178-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1412149617-3178-1-git-send-email-shreyas@linux.vnet.ibm.com>
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/reg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 0c05059..cb65a73 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -371,6 +371,7 @@
 #define SPRN_DBAT7L	0x23F	/* Data BAT 7 Lower Register */
 #define SPRN_DBAT7U	0x23E	/* Data BAT 7 Upper Register */
 #define SPRN_PPR	0x380	/* SMT Thread status Register */
+#define SPRN_TSCR	0x399	/* Thread Switch Control Register */
 
 #define SPRN_DEC	0x016		/* Decrement Register */
 #define SPRN_DER	0x095		/* Debug Enable Regsiter */
-- 
1.9.3
