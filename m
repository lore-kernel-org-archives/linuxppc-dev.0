Return-Path: <geoff@infradead.org>
Message-Id: <bdf0ccd43e7becc78c0f4895eb3f330a708443c0.1335379330.git.geoff@infradead.org>
In-Reply-To: <cover.1335379330.git.geoff@infradead.org>
References: <cover.1335379330.git.geoff@infradead.org>
From: Andre Heider <a.heider@gmail.com>
Subject: [PATCH 07/10] powerpc/ps3: Remove MEMORY_HOTPLUG requirement
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Sender: Geoff Levand <geoff@infradead.org>
Date: Wed, 25 Apr 2012 19:19:35 +0000
Cc: cbe-oss-dev@lists.ozlabs.org, Andre Heider <a.heider@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The dependency on hotplug memory was removed, so
remove the dependency in the Kconfig.

Signed-off-by: Andre Heider <a.heider@gmail.com>
Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/platforms/ps3/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/ps3/Kconfig b/arch/powerpc/platforms/ps3/Kconfig
index 4210aaa..b72425a 100644
--- a/arch/powerpc/platforms/ps3/Kconfig
+++ b/arch/powerpc/platforms/ps3/Kconfig
@@ -7,7 +7,6 @@ config PPC_PS3
 	select USB_OHCI_BIG_ENDIAN_MMIO
 	select USB_ARCH_HAS_EHCI
 	select USB_EHCI_BIG_ENDIAN_MMIO
-	select MEMORY_HOTPLUG
 	select PPC_PCI_CHOICE
 	help
 	  This option enables support for the Sony PS3 game console
-- 
1.7.9.5
