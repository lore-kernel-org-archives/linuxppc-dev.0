Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 905B11A0024
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 00:34:23 +1000 (AEST)
Message-Id: <a695a5c153c80e9343d488a3b4bb08d69d30639b.1442876807.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1442876807.git.christophe.leroy@c-s.fr>
References: <cover.1442876807.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/9] powerpc: unexport csum_tcpudp_magic
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
Date: Tue, 22 Sep 2015 16:34:19 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

csum_tcpudp_magic is now an inline function, so there is
nothing to export

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/lib/ppc_ksyms.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/lib/ppc_ksyms.c b/arch/powerpc/lib/ppc_ksyms.c
index c7f8e95..f5e427e 100644
--- a/arch/powerpc/lib/ppc_ksyms.c
+++ b/arch/powerpc/lib/ppc_ksyms.c
@@ -20,7 +20,6 @@ EXPORT_SYMBOL(strncmp);
 EXPORT_SYMBOL(csum_partial);
 EXPORT_SYMBOL(csum_partial_copy_generic);
 EXPORT_SYMBOL(ip_fast_csum);
-EXPORT_SYMBOL(csum_tcpudp_magic);
 #endif
 
 EXPORT_SYMBOL(__copy_tofrom_user);
-- 
2.1.0
