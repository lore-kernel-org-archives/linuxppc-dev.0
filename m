Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 17FC0DDE26
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jan 2007 16:13:48 +1100 (EST)
Date: Tue, 2 Jan 2007 16:13:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 2/2] [POWERPC] add legacy iSeries to ppc64_defconfig
Message-Id: <20070102161350.7e4259bb.sfr@canb.auug.org.au>
In-Reply-To: <20070102161109.8196128d.sfr@canb.auug.org.au>
References: <20070102161109.8196128d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/configs/ppc64_defconfig |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

This has been booted on iSeries, pSeries and pmac.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 35811cc..340376a 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.20-rc3
-# Tue Jan  2 15:20:02 2007
+# Tue Jan  2 15:32:44 2007
 #
 CONFIG_PPC64=y
 CONFIG_64BIT=y
@@ -133,7 +133,7 @@ CONFIG_PPC_MULTIPLATFORM=y
 # CONFIG_EMBEDDED6xx is not set
 # CONFIG_APUS is not set
 CONFIG_PPC_PSERIES=y
-# CONFIG_PPC_ISERIES is not set
+CONFIG_PPC_ISERIES=y
 # CONFIG_PPC_MPC52xx is not set
 CONFIG_PPC_PMAC=y
 CONFIG_PPC_PMAC64=y
@@ -834,6 +834,7 @@ CONFIG_IBMOL=y
 # Wan interfaces
 #
 # CONFIG_WAN is not set
+CONFIG_ISERIES_VETH=m
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
 CONFIG_PPP=m
@@ -946,6 +947,7 @@ CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
 CONFIG_HVC_DRIVER=y
 CONFIG_HVC_CONSOLE=y
+CONFIG_HVC_ISERIES=y
 CONFIG_HVC_RTAS=y
 CONFIG_HVCS=m
 
@@ -1652,6 +1654,15 @@ CONFIG_NLS_UTF8=m
 # CONFIG_DLM is not set
 
 #
+# iSeries device drivers
+#
+# CONFIG_VIOCONS is not set
+CONFIG_VIODASD=y
+CONFIG_VIOCD=m
+CONFIG_VIOTAPE=m
+CONFIG_VIOPATH=y
+
+#
 # Library routines
 #
 CONFIG_BITREVERSE=y
-- 
1.4.4.3
