Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8bsZ16lmzDt1x
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 18:18:10 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: anton@samba.org
Subject: [PATCH] powerpc/configs: Drop REISERFS from pseries & powernv
Date: Thu,  3 Nov 2016 18:18:07 +1100
Message-Id: <1478157487-1533-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

No one uses reiserfs much these days, or is likely to in future. So drop
it from pseries and powernv defconfigs to save time and space. It's
still enabled in ppc64_defconfig so we get some build coverage.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/powernv_defconfig | 4 ----
 arch/powerpc/configs/pseries_defconfig | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index d98b6eb3254f..d77af0eca967 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -241,10 +241,6 @@ CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
-CONFIG_REISERFS_FS=m
-CONFIG_REISERFS_FS_XATTR=y
-CONFIG_REISERFS_FS_POSIX_ACL=y
-CONFIG_REISERFS_FS_SECURITY=y
 CONFIG_JFS_FS=m
 CONFIG_JFS_POSIX_ACL=y
 CONFIG_JFS_SECURITY=y
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 8a3bc016b732..c8cee26fd9a0 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -244,10 +244,6 @@ CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
-CONFIG_REISERFS_FS=m
-CONFIG_REISERFS_FS_XATTR=y
-CONFIG_REISERFS_FS_POSIX_ACL=y
-CONFIG_REISERFS_FS_SECURITY=y
 CONFIG_JFS_FS=m
 CONFIG_JFS_POSIX_ACL=y
 CONFIG_JFS_SECURITY=y
-- 
2.7.4
