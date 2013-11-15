Return-Path: <Shengzhou.Liu@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B5BD02C0146
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Nov 2013 23:08:35 +1100 (EST)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 3/3] powerpc/fsl-booke: Enable T2080QDS board
Date: Fri, 15 Nov 2013 19:22:42 +0800
Message-ID: <1384514562-21137-3-git-send-email-Shengzhou.Liu@freescale.com>
In-Reply-To: <1384514562-21137-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1384514562-21137-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
 arch/powerpc/include/asm/mpc85xx.h            | 2 ++
 arch/powerpc/platforms/85xx/Kconfig           | 2 +-
 arch/powerpc/platforms/85xx/corenet_generic.c | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/mpc85xx.h b/arch/powerpc/include/asm/mpc85xx.h
index 736d4ac..3bef74a 100644
--- a/arch/powerpc/include/asm/mpc85xx.h
+++ b/arch/powerpc/include/asm/mpc85xx.h
@@ -77,6 +77,8 @@
 #define SVR_T1020	0x852100
 #define SVR_T1021	0x852101
 #define SVR_T1022	0x852102
+#define SVR_T2080	0x853000
+#define SVR_T2081	0x853100
 
 #define SVR_8610	0x80A000
 #define SVR_8641	0x809000
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 4d46349..b3436f8 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -259,7 +259,7 @@ config CORENET_GENERIC
 	  For 32bit kernel, the following boards are supported:
 	    P2041 RDB, P3041 DS and P4080 DS
 	  For 64bit kernel, the following boards are supported:
-	    T4240 QDS and B4 QDS
+	    T2080 QDS, T4240 QDS and B4 QDS
 	  The following boards are supported for both 32bit and 64bit kernel:
 	    P5020 DS and P5040 DS
 
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index fbd871e..5b8b10e 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -102,6 +102,7 @@ static const char * const boards[] __initconst = {
 	"fsl,P4080DS",
 	"fsl,P5020DS",
 	"fsl,P5040DS",
+	"fsl,T2080QDS",
 	"fsl,T4240QDS",
 	"fsl,B4860QDS",
 	"fsl,B4420QDS",
@@ -115,6 +116,7 @@ static const char * const hv_boards[] __initconst = {
 	"fsl,P4080DS-hv",
 	"fsl,P5020DS-hv",
 	"fsl,P5040DS-hv",
+	"fsl,T2080QDS-hv",
 	"fsl,T4240QDS-hv",
 	"fsl,B4860QDS-hv",
 	"fsl,B4420QDS-hv",
-- 
1.8.0
