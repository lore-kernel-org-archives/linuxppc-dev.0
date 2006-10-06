Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 7643367EBA
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Oct 2006 08:40:21 +1000 (EST)
Date: Fri, 6 Oct 2006 17:40:06 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Add 8360 to platforms/83xx/Kconfig
Message-Id: <20061006174006.1fe6c6e4.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

apparently this code didn't make it in last time,
so I'm adding it back again here.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/platforms/83xx/Kconfig |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index 0975e94..7edb6b4 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -32,6 +32,13 @@ config MPC834x_ITX
 	  Be aware that PCI initialization is the bootloader's
 	  responsiblilty.
 
+config MPC8360E_PB
+	bool "Freescale MPC8360E PB"
+	select DEFAULT_UIMAGE
+	select QUICC_ENGINE
+	help
+	  This option enables support for the MPC836x EMDS Processor Board.
+
 endchoice
 
 config PPC_MPC832x
@@ -46,4 +53,10 @@ config MPC834x
 	select PPC_INDIRECT_PCI
 	default y if MPC834x_SYS || MPC834x_ITX
 
+config PPC_MPC836x
+	bool
+	select PPC_UDBG_16550
+	select PPC_INDIRECT_PCI
+	default y if MPC8360E_PB
+
 endmenu
-- 
1.4.2.3
