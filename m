Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 684F01A0295
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 02:50:37 +1000 (AEST)
Message-Id: <0cb6258c48150d02bd7b65a6bc3b49e758d52aba.1442939410.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1442939410.git.christophe.leroy@c-s.fr>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 03/25] powerpc: Update documentation for noltlbs kernel
 parameter
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 22 Sep 2015 18:50:33 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now the noltlbs kernel parameter is also applicable to PPC8xx

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
No change in v2

 Documentation/kernel-parameters.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index c6dd5f3..cf28d9e 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2488,7 +2488,7 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 	nolapic_timer	[X86-32,APIC] Do not use the local APIC timer.
 
 	noltlbs		[PPC] Do not use large page/tlb entries for kernel
-			lowmem mapping on PPC40x.
+			lowmem mapping on PPC40x and PPC8xx
 
 	nomca		[IA-64] Disable machine check abort handling
 
-- 
2.1.0
