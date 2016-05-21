Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lb0-x244.google.com (mail-lb0-x244.google.com
 [IPv6:2a00:1450:4010:c04::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk3v2K3HzDqJq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:03:55 +1000 (AEST)
Received: by mail-lb0-x244.google.com with SMTP id r5so6878918lbj.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:03:55 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, aneesh.kumar@linux.vnet.ibm.com,
 david@gibson.dropbear.id.au, aik@ozlabs.ru, mikey@neuling.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0212/1529] Fix typo
Date: Sat, 21 May 2016 14:03:46 +0200
Message-Id: <20160521120346.10972-1-andrea.gelmini@gelma.net>
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
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 290157e..9643092 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -434,7 +434,7 @@ extern void slb_set_size(u16 size);
  * function.  Used in slb_allocate() and do_stab_bolted.  The function
  * computed is: (protovsid*VSID_MULTIPLIER) % VSID_MODULUS
  *
- *	rt = register continaing the proto-VSID and into which the
+ *	rt = register containing the proto-VSID and into which the
  *		VSID will be stored
  *	rx = scratch register (clobbered)
  *
-- 
2.8.2.534.g1f66975
