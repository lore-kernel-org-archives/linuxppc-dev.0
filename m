Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id A8E1467CA2
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 22:17:11 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k8LCHAcP008208
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 05:17:10 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k8LCH8Xu000018
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 07:17:09 -0500 (CDT)
Message-ID: <451282E8.7080403@freescale.com>
Date: Thu, 21 Sep 2006 20:17:44 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/11] qe_lib: Add QE Kconfig
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com>

---
 arch/powerpc/Kconfig |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 694b0c6..c907792 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -355,6 +355,16 @@ config APUS
 	  <http://linux-apus.sourceforge.net/>.
 endchoice
 
+config QUICC_ENGINE
+	bool
+	depends on MPC836x
+	default y
+	help
+	  The QE(QUICC Engine) is a new generation of coprocessor on 
+	  Freescale embedded CPUs(like CPM  in older chips).  Selecting
+	  this option means that you wish to build a kernel for a machine
+	  with QE coprocessor on it.
+
 config PPC_PSERIES
 	depends on PPC_MULTIPLATFORM && PPC64
 	bool "IBM pSeries & new (POWER5-based) iSeries"
@@ -1047,6 +1057,8 @@ # XXX source "arch/ppc/8xx_io/Kconfig"
 
 # XXX source "arch/ppc/8260_io/Kconfig"
 
+source "arch/powerpc/sysdev/qe_lib/Kconfig"
+
 source "arch/powerpc/platforms/iseries/Kconfig"
 
 source "lib/Kconfig"
