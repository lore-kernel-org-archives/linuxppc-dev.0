Return-Path: <albert_herranz@yahoo.es>
Received: from smtp141.mail.ukl.yahoo.com (smtp141.mail.ukl.yahoo.com
	[77.238.184.72]) by ozlabs.org (Postfix) with SMTP id 9A2F7B7BDC
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 29 Nov 2009 07:44:11 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v2 05/11] powerpc: gamecube/wii: declare as non-coherent
	platforms
Date: Sat, 28 Nov 2009 21:43:51 +0100
Message-Id: <1259441037-15725-6-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1259441037-15725-1-git-send-email-albert_herranz@yahoo.es>
References: <1259441037-15725-1-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The processors bundled in the Nintendo GameCube and Wii video game consoles
require explicit cache handling when DMA engines are used.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/powerpc/platforms/Kconfig.cputype |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index e382cae..80d934b 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -312,7 +312,7 @@ config NR_CPUS
 
 config NOT_COHERENT_CACHE
 	bool
-	depends on 4xx || 8xx || E200 || PPC_MPC512x
+	depends on 4xx || 8xx || E200 || PPC_MPC512x || GAMECUBE_COMMON
 	default y
 
 config CHECK_CACHE_COHERENCY
-- 
1.6.3.3
