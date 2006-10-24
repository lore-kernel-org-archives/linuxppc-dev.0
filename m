Return-Path: <arnd@arndb.de>
Message-Id: <20061024160407.408335000@arndb.de>
References: <20061024160140.452484000@arndb.de>
Date: Tue, 24 Oct 2006 18:01:43 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/3] cell: update defconfig
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

===================================================================
--- linux-2.6.orig/arch/powerpc/configs/cell_defconfig
+++ linux-2.6/arch/powerpc/configs/cell_defconfig
@@ -254,6 +254,7 @@ CONFIG_SYN_COOKIES=y
 CONFIG_INET_TUNNEL=y
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
+# CONFIG_INET_XFRM_MODE_BEET is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
@@ -275,7 +276,9 @@ CONFIG_INET6_XFRM_TUNNEL=m
 CONFIG_INET6_TUNNEL=m
 CONFIG_INET6_XFRM_MODE_TRANSPORT=y
 CONFIG_INET6_XFRM_MODE_TUNNEL=y
+# CONFIG_INET6_XFRM_MODE_BEET is not set
 # CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
+# CONFIG_IPV6_SIT is not set
 CONFIG_IPV6_TUNNEL=m
 # CONFIG_IPV6_SUBTREES is not set
 # CONFIG_IPV6_MULTIPLE_TABLES is not set
@@ -406,6 +409,12 @@ CONFIG_BLK_DEV_INITRD=y
 # CONFIG_ATA_OVER_ETH is not set
 
 #
+# Misc devices
+#
+# CONFIG_SGI_IOC4 is not set
+# CONFIG_TIFM_CORE is not set
+
+#
 # ATA/ATAPI/MFM/RLL support
 #
 CONFIG_IDE=y
@@ -738,7 +747,6 @@ CONFIG_GEN_RTC=y
 # TPM devices
 #
 # CONFIG_TCG_TPM is not set
-# CONFIG_TELCLOCK is not set
 
 #
 # I2C support
@@ -802,6 +810,7 @@ CONFIG_I2C_ALGOBIT=y
 #
 # Dallas's 1-wire bus
 #
+# CONFIG_W1 is not set
 
 #
 # Hardware Monitoring support
@@ -810,14 +819,9 @@ CONFIG_I2C_ALGOBIT=y
 # CONFIG_HWMON_VID is not set
 
 #
-# Misc devices
-#
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
-CONFIG_VIDEO_V4L2=y
 
 #
 # Digital Video Broadcasting Devices
@@ -923,6 +927,7 @@ CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_POSIX_ACL is not set
 # CONFIG_EXT3_FS_SECURITY is not set
+# CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
@@ -930,6 +935,7 @@ CONFIG_FS_MBCACHE=y
 # CONFIG_JFS_FS is not set
 CONFIG_FS_POSIX_ACL=y
 # CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -1129,6 +1135,7 @@ CONFIG_DEBUG_FS=y
 # CONFIG_DEBUG_VM is not set
 # CONFIG_DEBUG_LIST is not set
 # CONFIG_FORCED_INLINING is not set
+# CONFIG_HEADERS_CHECK is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_DEBUG_STACKOVERFLOW is not set
 # CONFIG_DEBUG_STACK_USAGE is not set

--
