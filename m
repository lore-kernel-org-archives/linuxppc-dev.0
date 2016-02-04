Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 79B331A0282
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 21:33:25 +1100 (AEDT)
Message-Id: <55d05c8c6f235afa97c404179d68f31509544ff3.1454581227.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1454581226.git.christophe.leroy@c-s.fr>
References: <cover.1454581226.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v6 11/23] powerpc32: Remove useless/wrong MMU:setio progress
 message
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu,  4 Feb 2016 11:33:23 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 771168494719 ("[POWERPC] Remove unused machine call outs")
removed the call to setup_io_mappings(), so remove the associated
progress line message

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: no change
v3: no change
v4: no change
v5: no change
v6: no change

 arch/powerpc/mm/init_32.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 1a18e4b..4eb1b8f 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -178,10 +178,6 @@ void __init MMU_init(void)
 	/* Initialize early top-down ioremap allocator */
 	ioremap_bot = IOREMAP_TOP;
 
-	/* Map in I/O resources */
-	if (ppc_md.progress)
-		ppc_md.progress("MMU:setio", 0x302);
-
 	if (ppc_md.progress)
 		ppc_md.progress("MMU:exit", 0x211);
 
-- 
2.1.0
