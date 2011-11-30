Return-Path: <anton@samba.org>
Date: Wed, 30 Nov 2011 21:38:20 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: Enable squashfs as a module
Message-ID: <20111130213820.39f16159@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Most distros use it so we may as well enable it and get regular compile
testing.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-powerpc/arch/powerpc/configs/ppc64_defconfig
===================================================================
--- linux-powerpc.orig/arch/powerpc/configs/ppc64_defconfig	2011-11-03 10:36:30.106405452 +1100
+++ linux-powerpc/arch/powerpc/configs/ppc64_defconfig	2011-11-03 10:49:15.731301312 +1100
@@ -390,6 +390,11 @@ CONFIG_HUGETLBFS=y
 CONFIG_HFS_FS=m
 CONFIG_HFSPLUS_FS=m
 CONFIG_CRAMFS=m
+CONFIG_SQUASHFS=m
+CONFIG_SQUASHFS_XATTR=y
+CONFIG_SQUASHFS_ZLIB=y
+CONFIG_SQUASHFS_LZO=y
+CONFIG_SQUASHFS_XZ=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_NFS_V3_ACL=y
Index: linux-powerpc/arch/powerpc/configs/pseries_defconfig
===================================================================
--- linux-powerpc.orig/arch/powerpc/configs/pseries_defconfig	2011-11-03 10:36:30.130405855 +1100
+++ linux-powerpc/arch/powerpc/configs/pseries_defconfig	2011-11-03 10:49:15.731301312 +1100
@@ -304,6 +304,11 @@ CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_HUGETLBFS=y
 CONFIG_CRAMFS=m
+CONFIG_SQUASHFS=m
+CONFIG_SQUASHFS_XATTR=y
+CONFIG_SQUASHFS_ZLIB=y
+CONFIG_SQUASHFS_LZO=y
+CONFIG_SQUASHFS_XZ=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_NFS_V3_ACL=y
