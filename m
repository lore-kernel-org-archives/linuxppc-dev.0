Return-Path: <galak@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 7323A6816B
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Sep 2005 02:47:11 +1000 (EST)
Date: Tue, 6 Sep 2005 11:46:58 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0509061146270.2183@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc32: Fix Kconfig mismerge
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Looks like the help comment for MPC834x got merged incorrectly.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 28806bb4f8992eb46d2d788a00d08f62b4559d61
tree de364c30cb32f279b3b01f13f683d0fd88416bb9
parent 2dcbb32c37cd71d9f4a7f5530af896a18d859ef5
author Kumar K. Gala <kumar.gala@freescale.com> Tue, 06 Sep 2005 11:24:52 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Tue, 06 Sep 2005 11:24:52 -0500

 arch/ppc/Kconfig |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -495,11 +495,6 @@ config WINCEPT
 	  MPC821 PowerPC, introduced in 1998 and designed to be used in
 	  thin-client machines.  Say Y to support it directly.
 
-	  Be aware that PCI buses can only function when SYS board is plugged
-	  into the PIB (Platform IO Board) board from Freescale which provide
-	  3 PCI slots.  The PIBs PCI initialization is the bootloader's
-	  responsiblilty.
-
 endchoice
 
 choice
@@ -675,6 +670,11 @@ config MPC834x_SYS
 	bool "Freescale MPC834x SYS"
 	help
 	  This option enables support for the MPC 834x SYS evaluation board.
+
+	  Be aware that PCI buses can only function when SYS board is plugged
+	  into the PIB (Platform IO Board) board from Freescale which provide
+	  3 PCI slots.  The PIBs PCI initialization is the bootloader's
+	  responsiblilty.
 
 config EV64360
 	bool "Marvell-EV64360BP"
