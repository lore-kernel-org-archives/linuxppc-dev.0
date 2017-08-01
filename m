Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMDXN1c1XzDrnL
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 21:25:56 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id u185so2263742pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Aug 2017 04:25:56 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com,
	Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v1 2/3] Enable ARCH_HAS_SET_MEMORY
Date: Tue,  1 Aug 2017 21:25:34 +1000
Message-Id: <20170801112535.20765-3-bsingharora@gmail.com>
In-Reply-To: <20170801112535.20765-1-bsingharora@gmail.com>
References: <20170801112535.20765-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b5b8ba8..7be710d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -165,6 +165,7 @@ config PPC
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
+	select ARCH_HAS_SET_MEMORY		if (PPC_BOOK3S_64)
 	select ARCH_HAS_STRICT_KERNEL_RWX	if (PPC_BOOK3S_64 && !HIBERNATION)
 	select ARCH_OPTIONAL_KERNEL_RWX		if ARCH_HAS_STRICT_KERNEL_RWX
 	select HAVE_CBPF_JIT			if !PPC64
-- 
2.9.4
