Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lb0-x241.google.com (mail-lb0-x241.google.com
 [IPv6:2a00:1450:4010:c04::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk700GgQzDqWd
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:06:36 +1000 (AEST)
Received: by mail-lb0-x241.google.com with SMTP id mx9so6879797lbb.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:06:35 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0229/1529] Fix typo
Date: Sat, 21 May 2016 14:06:27 +0200
Message-Id: <20160521120627.11896-1-andrea.gelmini@gelma.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/powerpc/lib/rheap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/rheap.c b/arch/powerpc/lib/rheap.c
index 69abf84..94058c2 100644
--- a/arch/powerpc/lib/rheap.c
+++ b/arch/powerpc/lib/rheap.c
@@ -325,7 +325,7 @@ void rh_init(rh_info_t * info, unsigned int alignment, int max_blocks,
 }
 EXPORT_SYMBOL_GPL(rh_init);
 
-/* Attach a free memory region, coalesces regions if adjuscent */
+/* Attach a free memory region, coalesces regions if adjacent */
 int rh_attach_region(rh_info_t * info, unsigned long start, int size)
 {
 	rh_block_t *blk;
-- 
2.8.2.534.g1f66975
