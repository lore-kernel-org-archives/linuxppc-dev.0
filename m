Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcbn32hLXzDrHC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 15:38:15 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 04/46] powerpc/configs: Drop no longer needed CONFIG_FHANDLE
Date: Wed, 23 Aug 2017 15:37:24 +1000
Message-Id: <1503466686-10932-5-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1503466686-10932-1-git-send-email-mpe@ellerman.id.au>
References: <1503466686-10932-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since commit f76be61755c5 ("Make CONFIG_FHANDLE default y") we no
longer need to set CONFIG_FHANDLE in our defconfigs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/cell_defconfig    | 1 -
 arch/powerpc/configs/g5_defconfig      | 1 -
 arch/powerpc/configs/maple_defconfig   | 1 -
 arch/powerpc/configs/pasemi_defconfig  | 1 -
 arch/powerpc/configs/powernv_defconfig | 1 -
 arch/powerpc/configs/ppc64_defconfig   | 1 -
 arch/powerpc/configs/ppc64e_defconfig  | 1 -
 arch/powerpc/configs/ps3_defconfig     | 1 -
 arch/powerpc/configs/pseries_defconfig | 1 -
 9 files changed, 9 deletions(-)

diff --git a/arch/powerpc/configs/cell_defconfig b/arch/powerpc/configs/cell_defconfig
index 2950aa97878b..e4229603eb85 100644
--- a/arch/powerpc/configs/cell_defconfig
+++ b/arch/powerpc/configs/cell_defconfig
@@ -4,7 +4,6 @@ CONFIG_ALTIVEC=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=4
 CONFIG_SYSVIPC=y
-CONFIG_FHANDLE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
index 6e957e98b108..7d225ccd986f 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -4,7 +4,6 @@ CONFIG_SMP=y
 CONFIG_NR_CPUS=4
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
-CONFIG_FHANDLE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
diff --git a/arch/powerpc/configs/maple_defconfig b/arch/powerpc/configs/maple_defconfig
index 0ebd376d8829..078cdb427fc9 100644
--- a/arch/powerpc/configs/maple_defconfig
+++ b/arch/powerpc/configs/maple_defconfig
@@ -3,7 +3,6 @@ CONFIG_SMP=y
 CONFIG_NR_CPUS=4
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
-CONFIG_FHANDLE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
diff --git a/arch/powerpc/configs/pasemi_defconfig b/arch/powerpc/configs/pasemi_defconfig
index 2168d76764e9..e8fd46f5d923 100644
--- a/arch/powerpc/configs/pasemi_defconfig
+++ b/arch/powerpc/configs/pasemi_defconfig
@@ -3,7 +3,6 @@ CONFIG_ALTIVEC=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_SYSVIPC=y
-CONFIG_FHANDLE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index 28de9139e914..7aa095a0bec6 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -4,7 +4,6 @@ CONFIG_NR_CPUS=2048
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
-CONFIG_FHANDLE=y
 CONFIG_AUDIT=y
 CONFIG_IRQ_DOMAIN_DEBUG=y
 CONFIG_NO_HZ=y
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index c97fcbded986..f00e08b2857d 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -2,7 +2,6 @@ CONFIG_PPC64=y
 CONFIG_SMP=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
-CONFIG_FHANDLE=y
 CONFIG_IRQ_DOMAIN_DEBUG=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
diff --git a/arch/powerpc/configs/ppc64e_defconfig b/arch/powerpc/configs/ppc64e_defconfig
index 7f34b3546092..1f5e0b107083 100644
--- a/arch/powerpc/configs/ppc64e_defconfig
+++ b/arch/powerpc/configs/ppc64e_defconfig
@@ -3,7 +3,6 @@ CONFIG_PPC_BOOK3E_64=y
 CONFIG_SMP=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
-CONFIG_FHANDLE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_TASKSTATS=y
diff --git a/arch/powerpc/configs/ps3_defconfig b/arch/powerpc/configs/ps3_defconfig
index 240f39670794..378382683180 100644
--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -5,7 +5,6 @@ CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
-CONFIG_FHANDLE=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 75707d669afc..e89bbd133aaf 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -3,7 +3,6 @@ CONFIG_SMP=y
 CONFIG_NR_CPUS=2048
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
-CONFIG_FHANDLE=y
 CONFIG_AUDIT=y
 CONFIG_AUDITSYSCALL=y
 CONFIG_IRQ_DOMAIN_DEBUG=y
-- 
2.7.4
