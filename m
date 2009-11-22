Return-Path: <albert_herranz@yahoo.es>
Received: from smtp106.mail.ukl.yahoo.com (smtp106.mail.ukl.yahoo.com
	[77.238.184.38]) by ozlabs.org (Postfix) with SMTP id 9A4061007F7
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 09:02:07 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 06/19] powerpc: gamecube/wii: introduce GAMECUBE_COMMON
Date: Sun, 22 Nov 2009 23:01:37 +0100
Message-Id: <1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a config option GAMECUBE_COMMON to be used as a dependency for all
options common to the Nintendo GameCube and Wii video game consoles.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/powerpc/platforms/embedded6xx/Kconfig |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index 291ac9d..97a2dbc 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -90,3 +90,7 @@ config MPC10X_OPENPIC
 config MPC10X_STORE_GATHERING
 	bool "Enable MPC10x store gathering"
 	depends on MPC10X_BRIDGE
+
+config GAMECUBE_COMMON
+	bool
+
-- 
1.6.3.3
