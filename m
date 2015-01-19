Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D41161A0D16
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 10:24:35 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 hbabu@us.ibm.com, nacc@linux.vnet.ibm.com
Subject: [PATCH 5/7] powerpc: Enable overlayfs on pseries and ppc64 defconfigs
Date: Tue, 20 Jan 2015 10:24:23 +1100
Message-Id: <1421709865-6368-5-git-send-email-anton@samba.org>
In-Reply-To: <1421709865-6368-1-git-send-email-anton@samba.org>
References: <1421709865-6368-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/configs/ppc64_defconfig      | 1 +
 arch/powerpc/configs/pseries_defconfig    | 1 +
 arch/powerpc/configs/pseries_le_defconfig | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 8a5509e..d664bc3 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -291,6 +291,7 @@ CONFIG_BTRFS_FS_POSIX_ACL=y
 CONFIG_NILFS2_FS=m
 CONFIG_AUTOFS4_FS=m
 CONFIG_FUSE_FS=m
+CONFIG_OVERLAY_FS=m
 CONFIG_ISO9660_FS=y
 CONFIG_UDF_FS=m
 CONFIG_MSDOS_FS=y
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 7677850..dbcef63 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -242,6 +242,7 @@ CONFIG_BTRFS_FS_POSIX_ACL=y
 CONFIG_NILFS2_FS=m
 CONFIG_AUTOFS4_FS=m
 CONFIG_FUSE_FS=m
+CONFIG_OVERLAY_FS=m
 CONFIG_ISO9660_FS=y
 CONFIG_UDF_FS=m
 CONFIG_MSDOS_FS=y
diff --git a/arch/powerpc/configs/pseries_le_defconfig b/arch/powerpc/configs/pseries_le_defconfig
index acb611a..14a7a7a 100644
--- a/arch/powerpc/configs/pseries_le_defconfig
+++ b/arch/powerpc/configs/pseries_le_defconfig
@@ -243,6 +243,7 @@ CONFIG_BTRFS_FS_POSIX_ACL=y
 CONFIG_NILFS2_FS=m
 CONFIG_AUTOFS4_FS=m
 CONFIG_FUSE_FS=m
+CONFIG_OVERLAY_FS=m
 CONFIG_ISO9660_FS=y
 CONFIG_UDF_FS=m
 CONFIG_MSDOS_FS=y
-- 
2.1.0
