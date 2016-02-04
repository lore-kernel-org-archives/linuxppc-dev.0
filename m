Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 27B391A025E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 21:33:09 +1100 (AEDT)
Message-Id: <9a9df3f1570cc5778c39d9034f39e1efc764a5c4.1454581227.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1454581226.git.christophe.leroy@c-s.fr>
References: <cover.1454581226.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v6 03/23] powerpc: Update documentation for noltlbs kernel
 parameter
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org
Date: Thu,  4 Feb 2016 11:33:07 +0100 (CET)
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
v2: no change
v3: no change
v4: no change
v5: no change
v6: no change

 Documentation/kernel-parameters.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 59e1515..c3e420b 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2592,7 +2592,7 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 	nolapic_timer	[X86-32,APIC] Do not use the local APIC timer.
 
 	noltlbs		[PPC] Do not use large page/tlb entries for kernel
-			lowmem mapping on PPC40x.
+			lowmem mapping on PPC40x and PPC8xx
 
 	nomca		[IA-64] Disable machine check abort handling
 
-- 
2.1.0
