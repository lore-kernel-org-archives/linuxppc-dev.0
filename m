Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1D59E1007D4
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Oct 2010 09:56:30 +1100 (EST)
Message-Id: <201010202256.o9KMuPg5009418@imap1.linux-foundation.org>
Subject: [patch 1/1] powerpc: enable ARCH_DMA_ADDR_T_64BIT with
	ARCH_PHYS_ADDR_T_64BIT
To: benh@kernel.crashing.org
From: akpm@linux-foundation.org
Date: Wed, 20 Oct 2010 15:56:24 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Cc: fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@ozlabs.org,
	akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/powerpc/Kconfig |    3 +++
 1 file changed, 3 insertions(+)

diff -puN arch/powerpc/Kconfig~powerpc-enable-arch_dma_addr_t_64bit-with-arch_phys_addr_t_64bit arch/powerpc/Kconfig
--- a/arch/powerpc/Kconfig~powerpc-enable-arch_dma_addr_t_64bit-with-arch_phys_addr_t_64bit
+++ a/arch/powerpc/Kconfig
@@ -16,6 +16,9 @@ config WORD_SIZE
 config ARCH_PHYS_ADDR_T_64BIT
        def_bool PPC64 || PHYS_64BIT
 
+config ARCH_DMA_ADDR_T_64BIT
+	def_bool ARCH_PHYS_ADDR_T_64BIT
+
 config MMU
 	bool
 	default y
_
