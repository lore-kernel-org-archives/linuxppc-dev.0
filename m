Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t4GvX1hVBzDvJS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 17:19:52 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id s8so1641920pfj.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 23:19:52 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kvm-ppc@vger.kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
 paulus@samba.org, agraf@suse.com,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: [PATCH 1/2] powerpc: Define new ISA v3.00 logical PVR value and PCR
 register value
Date: Thu, 27 Oct 2016 17:19:28 +1100
Message-Id: <1477549169-3649-2-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1477549169-3649-1-git-send-email-sjitindarsingh@gmail.com>
References: <1477549169-3649-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ISA 3.00 adds the logical PVR value 0x0f000005, so add a definition for
this.

Define PCR_ARCH_207 to reflect ISA 2.07 compatibility mode in the processor
compatibility register (PCR).

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/include/asm/reg.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 9cd4e8c..74c8079 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -377,6 +377,7 @@
 #define   PCR_VEC_DIS	(1ul << (63-0))	/* Vec. disable (bit NA since POWER8) */
 #define   PCR_VSX_DIS	(1ul << (63-1))	/* VSX disable (bit NA since POWER8) */
 #define   PCR_TM_DIS	(1ul << (63-2))	/* Trans. memory disable (POWER8) */
+#define   PCR_ARCH_207	0x8		/* Architecture 2.07 */
 #define   PCR_ARCH_206	0x4		/* Architecture 2.06 */
 #define   PCR_ARCH_205	0x2		/* Architecture 2.05 */
 #define	SPRN_HEIR	0x153	/* Hypervisor Emulated Instruction Register */
@@ -1218,6 +1219,7 @@
 #define PVR_ARCH_206	0x0f000003
 #define PVR_ARCH_206p	0x0f100003
 #define PVR_ARCH_207	0x0f000004
+#define PVR_ARCH_300	0x0f000005
 
 /* Macros for setting and retrieving special purpose registers */
 #ifndef __ASSEMBLY__
-- 
2.5.5
