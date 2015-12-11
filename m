Return-Path: <valentinrothberg@gmail.com>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 837E41A0657
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 18:46:44 +1100 (AEDT)
Received: by wmec201 with SMTP id c201so10124172wme.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 23:46:40 -0800 (PST)
From: Valentin Rothberg <valentinrothberg@gmail.com>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Valentin Rothberg <valentinrothberg@gmail.com>
Subject: [PATCH] arch/powerpc/Kconfig: fix typo in select statement
Date: Fri, 11 Dec 2015 08:46:28 +0100
Message-Id: <1449819988-28603-1-git-send-email-valentinrothberg@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The 'I' in sanitize was missing:
s/ARCH_HAS_UBSAN_SANTIZE_ALL/ARCH_HAS_UBSAN_SANITIZE_ALL/

Fixes: 257e4ee82dbd ("powerpc: enable UBSAN support")
Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
---
Detected with ./scripts/checkkconfigsymbols.py

 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b0420a8c458e..4de86d145f17 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -157,7 +157,7 @@ config PPC
 	select EDAC_ATOMIC_SCRUB
 	select ARCH_HAS_DMA_SET_COHERENT_MASK
 	select HAVE_ARCH_SECCOMP_FILTER
-	select ARCH_HAS_UBSAN_SANTIZE_ALL
+	select ARCH_HAS_UBSAN_SANITIZE_ALL
 
 config GENERIC_CSUM
 	def_bool CPU_LITTLE_ENDIAN
-- 
2.1.4
