Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3txZMD5zghzDqbG
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jan 2017 10:32:24 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Steven Munroe <munroesj@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/9] powerpc: Remove obsolete comment about patching
 instructions
Date: Sun,  8 Jan 2017 17:31:44 -0600
Message-Id: <20170108233150.15353-3-benh@kernel.crashing.org>
In-Reply-To: <20170108233150.15353-1-benh@kernel.crashing.org>
References: <20170108233150.15353-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We don't patch instructions based on the cache lines or block
sizes these days.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/setup_64.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 6263e0d..222bbb0 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -77,9 +77,6 @@
 int spinning_secondaries;
 u64 ppc64_pft_size;
 
-/* Pick defaults since we might want to patch instructions
- * before we've read this from the device tree.
- */
 struct ppc64_caches ppc64_caches = {
 	.dline_size = 0x40,
 	.log_dline_size = 6,
-- 
2.9.3
