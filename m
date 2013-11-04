Return-Path: <michael.opdenacker@free-electrons.com>
Received: from mail.free-electrons.com (top.free-electrons.com [176.31.233.9])
 by ozlabs.org (Postfix) with ESMTP id C1B7C2C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Nov 2013 19:46:12 +1100 (EST)
From: Michael Opdenacker <michael.opdenacker@free-electrons.com>
To: benh@kernel.crashing.org, paulus@samba.org, galak@kernel.crashing.org,
 vitb@kernel.crashing.org, marcelo@kvack.org
Subject: [PATCH] powerpc: remove unused REDBOOT Kconfig parameter
Date: Mon,  4 Nov 2013 09:38:56 +0100
Message-Id: <1383554336-3829-1-git-send-email-michael.opdenacker@free-electrons.com>
Cc: Michael Opdenacker <michael.opdenacker@free-electrons.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This removes the REDBOOT Kconfig parameter,
which was no longer used anywhere in the source code
and Makefiles.

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 arch/powerpc/Kconfig                | 3 ---
 arch/powerpc/platforms/83xx/Kconfig | 1 -
 arch/powerpc/platforms/8xx/Kconfig  | 1 -
 3 files changed, 5 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 38f3b7e47ec5..f02a41935c95 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -205,9 +205,6 @@ config DEFAULT_UIMAGE
 	  Used to allow a board to specify it wants a uImage built by default
 	default n
 
-config REDBOOT
-	bool
-
 config ARCH_HIBERNATION_POSSIBLE
 	bool
 	default y
diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index 670a033264c0..2bdc8c862c46 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -99,7 +99,6 @@ config SBC834x
 config ASP834x
 	bool "Analogue & Micro ASP 834x"
 	select PPC_MPC834x
-	select REDBOOT
 	help
 	  This enables support for the Analogue & Micro ASP 83xx
 	  board.
diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
index 8dec3c0911ad..bd6f1a1cf922 100644
--- a/arch/powerpc/platforms/8xx/Kconfig
+++ b/arch/powerpc/platforms/8xx/Kconfig
@@ -45,7 +45,6 @@ config PPC_EP88XC
 config PPC_ADDER875
 	bool "Analogue & Micro Adder 875"
 	select CPM1
-	select REDBOOT
 	help
 	  This enables support for the Analogue & Micro Adder 875
 	  board.
-- 
1.8.1.2
