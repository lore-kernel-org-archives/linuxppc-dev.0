Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpN1F5sVZzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 08:22:09 +1100 (AEDT)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] powerpc/configs: Make oprofile a module
Date: Thu, 23 Mar 2017 08:22:00 +1100
Message-Id: <20170322212201.26036-2-anton@ozlabs.org>
In-Reply-To: <20170322212201.26036-1-anton@ozlabs.org>
References: <20170322212201.26036-1-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

Most people use perf these days, so save about 31kB by making oprofile
a module.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/configs/powernv_defconfig | 2 +-
 arch/powerpc/configs/ppc64_defconfig   | 2 +-
 arch/powerpc/configs/pseries_defconfig | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index eb78c74..4926d7f 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -33,7 +33,7 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_BPF_SYSCALL=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
-CONFIG_OPROFILE=y
+CONFIG_OPROFILE=m
 CONFIG_KPROBES=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index bdca32e..dfac33c 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -19,7 +19,7 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_BPF_SYSCALL=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
-CONFIG_OPROFILE=y
+CONFIG_OPROFILE=m
 CONFIG_KPROBES=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index cd26091..47f72c8 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -34,7 +34,7 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_BPF_SYSCALL=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
-CONFIG_OPROFILE=y
+CONFIG_OPROFILE=m
 CONFIG_KPROBES=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
-- 
2.9.3
