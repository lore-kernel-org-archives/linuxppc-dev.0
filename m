Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lb0-x241.google.com (mail-lb0-x241.google.com
 [IPv6:2a00:1450:4010:c04::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk950MmBzDqYC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:08:25 +1000 (AEST)
Received: by mail-lb0-x241.google.com with SMTP id t6so65739lbv.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:08:24 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, ruscur@russell.cc, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0244/1529] Fix typo
Date: Sat, 21 May 2016 14:08:17 +0200
Message-Id: <20160521120817.12731-1-andrea.gelmini@gelma.net>
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
 arch/powerpc/platforms/pseries/eeh_pseries.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index ac3ffd9..ef3147c 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -2,7 +2,7 @@
  * The file intends to implement the platform dependent EEH operations on pseries.
  * Actually, the pseries platform is built based on RTAS heavily. That means the
  * pseries platform dependent EEH operations will be built on RTAS calls. The functions
- * are devired from arch/powerpc/platforms/pseries/eeh.c and necessary cleanup has
+ * are derived from arch/powerpc/platforms/pseries/eeh.c and necessary cleanup has
  * been done.
  *
  * Copyright Benjamin Herrenschmidt & Gavin Shan, IBM Corporation 2011.
-- 
2.8.2.534.g1f66975
