Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lb0-x242.google.com (mail-lb0-x242.google.com
 [IPv6:2a00:1450:4010:c04::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk9N5fkYzDqZc
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:08:40 +1000 (AEST)
Received: by mail-lb0-x242.google.com with SMTP id t6so65879lbv.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:08:40 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, gwshan@linux.vnet.ibm.com, aik@ozlabs.ru,
 chris@distroguy.com, tglx@linutronix.de, sjitindarsingh@gmail.com,
 adam.buchbinder@gmail.com, marc.zyngier@arm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0246/1529] Fix typo
Date: Sat, 21 May 2016 14:08:32 +0200
Message-Id: <20160521120832.12838-1-andrea.gelmini@gelma.net>
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
 arch/powerpc/platforms/pseries/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 9883bc7..9a79c27 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -367,7 +367,7 @@ static void pseries_lpar_idle(void)
 {
 	/*
 	 * Default handler to go into low thread priority and possibly
-	 * low power mode by cedeing processor to hypervisor
+	 * low power mode by ceding processor to hypervisor
 	 */
 
 	/* Indicate to hypervisor that we are idle. */
-- 
2.8.2.534.g1f66975
