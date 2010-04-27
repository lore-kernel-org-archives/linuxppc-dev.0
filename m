Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id AB5BDB7E32
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 02:11:45 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linux-usb@vger.kernel.org
Subject: [PATCH 4/4] powerpc/mpc5121: select options for USB OTG support
Date: Tue, 27 Apr 2010 18:11:38 +0200
Message-Id: <1272384698-4359-5-git-send-email-agust@denx.de>
In-Reply-To: <1272384698-4359-1-git-send-email-agust@denx.de>
References: <1272384698-4359-1-git-send-email-agust@denx.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Wolfgang Denk <wd@denx.de>, Detlev Zundel <dzu@denx.de>,
	Greg Kroah-Hartman <gregkh@suse.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

USB Device Controller driver and OTG driver allow
configuration of controller register accessors.
Enable default big-endian register accessors for
Rev.2 SoC.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/platforms/512x/Kconfig |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms/512x/Kconfig
index fed7b5d..0c42537 100644
--- a/arch/powerpc/platforms/512x/Kconfig
+++ b/arch/powerpc/platforms/512x/Kconfig
@@ -12,6 +12,14 @@ config PPC_MPC5121
 	select USB_ARCH_HAS_EHCI
 	select USB_EHCI_BIG_ENDIAN_DESC
 	select USB_EHCI_BIG_ENDIAN_MMIO
+	select USB_FSL_BIG_ENDIAN_DESC
+	select USB_FSL_BIG_ENDIAN_MMIO
+
+config USB_FSL_BIG_ENDIAN_MMIO
+	bool
+
+config USB_FSL_BIG_ENDIAN_DESC
+	bool
 
 config MPC5121_ADS
 	bool "Freescale MPC5121E ADS"
-- 
1.6.3.3
