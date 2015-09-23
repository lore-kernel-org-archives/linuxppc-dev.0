Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 855931A0038
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 15:40:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>, linux-kbuild@vger.kernel.org,
 yann.morin.1998@free.fr, mmarek@suse.com
Subject: [RFC PATCH 2/2] powerpc: Add ppc64le_defconfig
Date: Wed, 23 Sep 2015 15:40:35 +1000
Message-Id: <1442986835-13985-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1442986835-13985-1-git-send-email-mpe@ellerman.id.au>
References: <1442986835-13985-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Based directly on ppc64_defconfig using merge_config.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index b9b4af2af9a5..3704db45a832 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -288,6 +288,10 @@ PHONY += pseries_le_defconfig
 pseries_le_defconfig:
 	$(call merge_into_defconfig,pseries_defconfig,le)
 
+PHONY += ppc64le_defconfig
+ppc64le_defconfig:
+	$(call merge_into_defconfig,ppc64_defconfig,le)
+
 PHONY += mpc85xx_defconfig
 mpc85xx_defconfig:
 	$(call merge_into_defconfig,mpc85xx_basic_defconfig,\
-- 
2.1.4
