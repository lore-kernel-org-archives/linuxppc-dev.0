Return-Path: <geoff@infradead.org>
Message-Id: <02ec92b3f312b7201928dc6d3225ed51635211b4.1335379330.git.geoff@infradead.org>
In-Reply-To: <cover.1335379330.git.geoff@infradead.org>
References: <cover.1335379330.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 08/10] powerpc/ps3: Minor Kconfig cleanup
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
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

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/platforms/ps3/Kconfig |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/Kconfig b/arch/powerpc/platforms/ps3/Kconfig
index b72425a..46b7f02 100644
--- a/arch/powerpc/platforms/ps3/Kconfig
+++ b/arch/powerpc/platforms/ps3/Kconfig
@@ -73,7 +73,7 @@ config PS3_PS3AV
 	help
 	  Include support for the PS3 AV Settings driver.
 
-	  This support is required for graphics and sound. In
+	  This support is required for PS3 graphics and sound. In
 	  general, all users will say Y or M.
 
 config PS3_SYS_MANAGER
@@ -84,7 +84,7 @@ config PS3_SYS_MANAGER
 	help
 	  Include support for the PS3 System Manager.
 
-	  This support is required for system control.  In
+	  This support is required for PS3 system control.  In
 	  general, all users will say Y or M.
 
 config PS3_REPOSITORY_WRITE
@@ -134,7 +134,7 @@ config PS3_FLASH
 
 	  This support is required to access the PS3 FLASH ROM, which
 	  contains the boot loader and some boot options.
-	  In general, all users will say Y or M.
+	  In general, PS3 OtherOS users will say Y or M.
 
 	  As this driver needs a fixed buffer of 256 KiB of memory, it can
 	  be disabled on the kernel command line using "ps3flash=off", to
@@ -168,7 +168,7 @@ config PS3GELIC_UDBG
 	  via the Ethernet port (UDP port number 18194).
 
 	  This driver uses a trivial implementation and is independent
-	  from the main network driver.
+	  from the main PS3 gelic network driver.
 
 	  If in doubt, say N here.
 
-- 
1.7.9.5
