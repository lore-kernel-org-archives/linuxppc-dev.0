Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYFMK3XCCzDqgr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 13:37:33 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id f27so36299466pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 20:37:33 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com, ananth@linux.vnet.ibm.com,
 christophe.leroy@c-s.fr, paulus@samba.org, rashmica.g@gmail.com,
 Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v1 7/8] powerpc/Kconfig: Enable STRICT_KERNEL_RWX
Date: Thu, 25 May 2017 13:36:49 +1000
Message-Id: <20170525033650.10891-8-bsingharora@gmail.com>
In-Reply-To: <20170525033650.10891-1-bsingharora@gmail.com>
References: <20170525033650.10891-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have the basic support in the form of patching R/O
text sections, linker scripts for extending alignment
of text data. We've also got mark_rodata_ro()

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index f7c8f99..8b3f03b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -171,6 +171,7 @@ config PPC
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
+	select ARCH_HAS_STRICT_KERNEL_RWX	if PPC64 && PPC_BOOK3S
 	select HAVE_CBPF_JIT			if !PPC64
 	select HAVE_CONTEXT_TRACKING		if PPC64
 	select HAVE_DEBUG_KMEMLEAK
-- 
2.9.3
