Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lb0-x242.google.com (mail-lb0-x242.google.com
 [IPv6:2a00:1450:4010:c04::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk8x0b6FzDqZc
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:08:17 +1000 (AEST)
Received: by mail-lb0-x242.google.com with SMTP id t6so65653lbv.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:08:16 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, aik@ozlabs.ru, gwshan@linux.vnet.ibm.com,
 david@gibson.dropbear.id.au, alistair@popple.id.au,
 weiyang@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0243/1529] Fix typo
Date: Sat, 21 May 2016 14:08:09 +0200
Message-Id: <20160521120809.12681-1-andrea.gelmini@gelma.net>
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
 arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 3a5ea82..1fc53e0 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -197,7 +197,7 @@ static int pnv_ioda2_init_m64(struct pnv_phb *phb)
 
 	/*
 	 * Strip off the segment used by the reserved PE, which is
-	 * expected to be 0 or last one of PE capabicity.
+	 * expected to be 0 or last one of PE capability.
 	 */
 	r = &phb->hose->mem_resources[1];
 	if (phb->ioda.reserved_pe_idx == 0)
-- 
2.8.2.534.g1f66975
