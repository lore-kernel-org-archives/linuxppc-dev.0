Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 9C456679FD
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Aug 2006 06:37:56 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k6VKbshM009497
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Jul 2006 13:37:54 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k6VKbsao029077
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Jul 2006 15:37:54 -0500 (CDT)
Subject: PATCH: Enable PCI by default on PPC_86xx boards
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1154378023.5107.39.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Mon, 31 Jul 2006 15:33:43 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Jon Loeliger <jdl@freescale.com>

---

 arch/powerpc/Kconfig |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 13e583f..abb325e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -836,9 +836,10 @@ config MCA
 	bool
 
 config PCI
-	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx ||
PPC_MPC52xx || (EMBEDDED && PPC_ISERIES) \
-				  || MPC7448HPC2
-	default y if !40x && !CPM2 && !8xx && !APUS && !PPC_83xx && !PPC_85xx
&& !PPC_86xx
+	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_86xx
\
+		|| PPC_MPC52xx || (EMBEDDED && PPC_ISERIES) || MPC7448HPC2
+	default y if !40x && !CPM2 && !8xx && !APUS && !PPC_83xx \
+		&& !PPC_85xx && !PPC_86xx
 	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx && APUS
 	default PCI_QSPAN if !4xx && !CPM2 && 8xx
 	help
