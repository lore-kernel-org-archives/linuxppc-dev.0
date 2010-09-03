Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C93FAB7189
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Sep 2010 11:01:08 +1000 (EST)
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
To: akpm@linux-foundation.org
Subject: [PATCH -mm 5/8] powerpc: enable ARCH_DMA_ADDR_T_64BIT with
	ARCH_PHYS_ADDR_T_64BIT
Date: Fri,  3 Sep 2010 09:49:13 +0900
Message-Id: <1283474956-14710-5-git-send-email-fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20100903094753S.fujita.tomonori@lab.ntt.co.jp>
References: <20100903094753S.fujita.tomonori@lab.ntt.co.jp>
Cc: linux-arch@vger.kernel.org, fujita.tomonori@lab.ntt.co.jp,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/Kconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 631e5a0..b0e58f5 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -22,6 +22,9 @@ config WORD_SIZE
 config ARCH_PHYS_ADDR_T_64BIT
        def_bool PPC64 || PHYS_64BIT
 
+config ARCH_DMA_ADDR_T_64BIT
+	def_bool ARCH_PHYS_ADDR_T_64BIT
+
 config MMU
 	bool
 	default y
-- 
1.7.1
