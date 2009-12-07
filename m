Return-Path: <anton@ozlabs.org>
Date: Mon, 7 Dec 2009 14:45:55 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 2/4] powerpc: Disable token ring in powerpc defconfigs
Message-ID: <20091207034555.GB3421@kryten>
References: <20091207034509.GA3421@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091207034509.GA3421@kryten>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Token what? Lets save some space in our powerpc kernels and remove token
ring support.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux.trees.git/arch/powerpc/configs/g5_defconfig
===================================================================
--- linux.trees.git.orig/arch/powerpc/configs/g5_defconfig	2009-11-26 12:35:15.000000000 +1100
+++ linux.trees.git/arch/powerpc/configs/g5_defconfig	2009-11-26 12:35:59.000000000 +1100
@@ -794,8 +794,8 @@ CONFIG_NETDEV_10000=y
 # CONFIG_BNX2X is not set
 # CONFIG_QLGE is not set
 # CONFIG_SFC is not set
-CONFIG_TR=y
-CONFIG_IBMOL=y
+# CONFIG_TR is not set
+# CONFIG_IBMOL is not set
 # CONFIG_3C359 is not set
 # CONFIG_TMS380TR is not set
 
Index: linux.trees.git/arch/powerpc/configs/iseries_defconfig
===================================================================
--- linux.trees.git.orig/arch/powerpc/configs/iseries_defconfig	2009-11-26 12:35:15.000000000 +1100
+++ linux.trees.git/arch/powerpc/configs/iseries_defconfig	2009-11-26 12:35:55.000000000 +1100
@@ -714,8 +714,8 @@ CONFIG_NETDEV_10000=y
 # CONFIG_BNX2X is not set
 # CONFIG_QLGE is not set
 # CONFIG_SFC is not set
-CONFIG_TR=y
-CONFIG_IBMOL=y
+# CONFIG_TR is not set
+# CONFIG_IBMOL is not set
 # CONFIG_3C359 is not set
 # CONFIG_TMS380TR is not set
 
Index: linux.trees.git/arch/powerpc/configs/ppc64_defconfig
===================================================================
--- linux.trees.git.orig/arch/powerpc/configs/ppc64_defconfig	2009-11-26 12:35:15.000000000 +1100
+++ linux.trees.git/arch/powerpc/configs/ppc64_defconfig	2009-11-26 12:35:51.000000000 +1100
@@ -1023,8 +1023,8 @@ CONFIG_PASEMI_MAC=y
 # CONFIG_BNX2X is not set
 # CONFIG_QLGE is not set
 # CONFIG_SFC is not set
-CONFIG_TR=y
-CONFIG_IBMOL=y
+# CONFIG_TR is not set
+# CONFIG_IBMOL is not set
 # CONFIG_3C359 is not set
 # CONFIG_TMS380TR is not set
 
Index: linux.trees.git/arch/powerpc/configs/ppc64e_defconfig
===================================================================
--- linux.trees.git.orig/arch/powerpc/configs/ppc64e_defconfig	2009-11-26 12:35:15.000000000 +1100
+++ linux.trees.git/arch/powerpc/configs/ppc64e_defconfig	2009-11-26 12:35:41.000000000 +1100
@@ -1008,8 +1008,8 @@ CONFIG_IXGB=m
 # CONFIG_QLGE is not set
 # CONFIG_SFC is not set
 # CONFIG_BE2NET is not set
-CONFIG_TR=y
-CONFIG_IBMOL=y
+# CONFIG_TR is not set
+# CONFIG_IBMOL is not set
 # CONFIG_3C359 is not set
 # CONFIG_TMS380TR is not set
 CONFIG_WLAN=y
Index: linux.trees.git/arch/powerpc/configs/pseries_defconfig
===================================================================
--- linux.trees.git.orig/arch/powerpc/configs/pseries_defconfig	2009-11-26 12:35:15.000000000 +1100
+++ linux.trees.git/arch/powerpc/configs/pseries_defconfig	2009-11-26 12:36:04.000000000 +1100
@@ -834,8 +834,8 @@ CONFIG_S2IO=m
 # CONFIG_BNX2X is not set
 # CONFIG_QLGE is not set
 # CONFIG_SFC is not set
-CONFIG_TR=y
-CONFIG_IBMOL=y
+# CONFIG_TR is not set
+# CONFIG_IBMOL is not set
 # CONFIG_3C359 is not set
 # CONFIG_TMS380TR is not set
 
