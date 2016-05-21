Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lb0-x241.google.com (mail-lb0-x241.google.com
 [IPv6:2a00:1450:4010:c04::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk420gMRzDqG6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:04:02 +1000 (AEST)
Received: by mail-lb0-x241.google.com with SMTP id t6so62480lbv.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:04:01 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, ruscur@russell.cc, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0213/1529] Fix typo
Date: Sat, 21 May 2016 14:03:53 +0200
Message-Id: <20160521120353.11023-1-andrea.gelmini@gelma.net>
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
 arch/powerpc/include/asm/eeh.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index fb9f376..7d34f3d 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -57,7 +57,7 @@ struct pci_dn;
 /*
  * The struct is used to trace PE related EEH functionality.
  * In theory, there will have one instance of the struct to
- * be created against particular PE. In nature, PEs corelate
+ * be created against particular PE. In nature, PEs correlate
  * to each other. the struct has to reflect that hierarchy in
  * order to easily pick up those affected PEs when one particular
  * PE has EEH errors.
-- 
2.8.2.534.g1f66975
