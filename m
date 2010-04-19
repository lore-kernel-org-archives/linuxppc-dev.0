Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: build in e1000e for pseries & ppc64_defconfig
Date: Mon, 19 Apr 2010 16:05:41 +1000
Message-ID: <30800.1271657141@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The e1000e device is becoming more common these days, so let's just
build it in for pseries & ppc64_defconfig.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/configs/ppc64_defconfig   |    2 +-
 arch/powerpc/configs/pseries_defconfig |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/configs/ppc64_defconfig
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/configs/ppc64_defconfig
+++ linux-2.6-ozlabs/arch/powerpc/configs/ppc64_defconfig
@@ -988,7 +988,7 @@ CONFIG_ACENIC=m
 CONFIG_ACENIC_OMIT_TIGON_I=y
 # CONFIG_DL2K is not set
 CONFIG_E1000=y
-CONFIG_E1000E=m
+CONFIG_E1000E=y
 # CONFIG_IP1000 is not set
 # CONFIG_IGB is not set
 # CONFIG_NS83820 is not set
Index: linux-2.6-ozlabs/arch/powerpc/configs/pseries_defconfig
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/configs/pseries_defconfig
+++ linux-2.6-ozlabs/arch/powerpc/configs/pseries_defconfig
@@ -804,7 +804,7 @@ CONFIG_ACENIC=m
 CONFIG_ACENIC_OMIT_TIGON_I=y
 # CONFIG_DL2K is not set
 CONFIG_E1000=y
-CONFIG_E1000E=m
+CONFIG_E1000E=y
 # CONFIG_IP1000 is not set
 # CONFIG_IGB is not set
 # CONFIG_NS83820 is not set
