Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpN1C6ld5zDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 08:22:07 +1100 (AEDT)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] powerpc/configs: Re-enable ISO9660_FS as a built-in in 64
 bit configs
Date: Thu, 23 Mar 2017 08:21:59 +1100
Message-Id: <20170322212201.26036-1-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

It turns out cloud-config uses ISO9660 filesystems to inject
configuration data into cloud images. The cloud-config failures when
ISO9660_FS is not enabled are cryptic, and building it in makes
mainline testing easier, so re-enable it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/configs/powernv_defconfig | 2 +-
 arch/powerpc/configs/ppc64_defconfig   | 2 +-
 arch/powerpc/configs/pseries_defconfig | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index ac8b833..eb78c74 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -261,7 +261,7 @@ CONFIG_NILFS2_FS=m
 CONFIG_AUTOFS4_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_OVERLAY_FS=m
-CONFIG_ISO9660_FS=m
+CONFIG_ISO9660_FS=y
 CONFIG_UDF_FS=m
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=m
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 4f1288b..bdca32e 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -291,7 +291,7 @@ CONFIG_NILFS2_FS=m
 CONFIG_AUTOFS4_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_OVERLAY_FS=m
-CONFIG_ISO9660_FS=m
+CONFIG_ISO9660_FS=y
 CONFIG_UDF_FS=m
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=m
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 4ff68b7..cd26091 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -259,7 +259,7 @@ CONFIG_NILFS2_FS=m
 CONFIG_AUTOFS4_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_OVERLAY_FS=m
-CONFIG_ISO9660_FS=m
+CONFIG_ISO9660_FS=y
 CONFIG_UDF_FS=m
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=m
-- 
2.9.3
