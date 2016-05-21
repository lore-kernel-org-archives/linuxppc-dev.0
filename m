Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com
 [IPv6:2a00:1450:4010:c07::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk5r0WKZzDqSh
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:05:36 +1000 (AEST)
Received: by mail-lf0-x242.google.com with SMTP id p10so3973096lfb.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:05:35 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, ruscur@russell.cc, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0223/1529] Fix typo
Date: Sat, 21 May 2016 14:05:26 +0200
Message-Id: <20160521120526.11583-1-andrea.gelmini@gelma.net>
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
 arch/powerpc/kernel/eeh_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 2714a3b..389b0d3 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -139,7 +139,7 @@ static void eeh_enable_irq(struct pci_dev *dev)
 		 * into it.
 		 *
 		 * That's just wrong.The warning in the core code is
-		 * there to tell people to fix their assymetries in
+		 * there to tell people to fix their asymmetries in
 		 * their own code, not by abusing the core information
 		 * to avoid it.
 		 *
-- 
2.8.2.534.g1f66975
