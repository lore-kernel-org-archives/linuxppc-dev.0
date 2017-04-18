Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6ZkC03hpzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 16:20:18 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/mm: Rename table dump file name
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20170418062015.8B69B6E624@localhost.localdomain>
Date: Tue, 18 Apr 2017 08:20:15 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Page table dump debugfs file is named 'kernel_page_tables' on
all other architectures implementing it, while is is named
'kernel_pagetables' on powerpc. This patch renames it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/dump_linuxpagetables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
index 71a31e47ec22..4ac1a286824e 100644
--- a/arch/powerpc/mm/dump_linuxpagetables.c
+++ b/arch/powerpc/mm/dump_linuxpagetables.c
@@ -448,7 +448,7 @@ static int ptdump_init(void)
 
 	populate_markers();
 	build_pgtable_complete_mask();
-	debugfs_file = debugfs_create_file("kernel_pagetables", 0400, NULL,
+	debugfs_file = debugfs_create_file("kernel_page_tables", 0400, NULL,
 			NULL, &ptdump_fops);
 	return debugfs_file ? 0 : -ENOMEM;
 }
-- 
2.12.0
