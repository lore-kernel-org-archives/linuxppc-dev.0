Return-Path: <Shengzhou.Liu@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C34C72C025E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Nov 2013 22:59:49 +1100 (EST)
Received: from mail202-co1 (localhost [127.0.0.1])	by
 mail202-co1-R.bigfish.com (Postfix) with ESMTP id 9B281D40B33	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Nov 2013 11:59:45 +0000 (UTC)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH 4/4 v2] powerpc/fsl-booke: Enable T208xQDS board
Date: Fri, 22 Nov 2013 19:12:52 +0800
Message-ID: <1385118772-15126-4-git-send-email-Shengzhou.Liu@freescale.com>
In-Reply-To: <1385118772-15126-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1385118772-15126-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shengzhou Liu <Shengzhou.Liu@freescale.com>
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
v2: add T2081QDS compatible.

 arch/powerpc/platforms/85xx/Kconfig           | 2 +-
 arch/powerpc/platforms/85xx/corenet_generic.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 4d46349..b3436f8 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -259,7 +259,7 @@ config CORENET_GENERIC
 	  For 32bit kernel, the following boards are supported:
 	    P2041 RDB, P3041 DS and P4080 DS
 	  For 64bit kernel, the following boards are supported:
-	    T4240 QDS and B4 QDS
+	    T208x QDS, T4240 QDS and B4 QDS
 	  The following boards are supported for both 32bit and 64bit kernel:
 	    P5020 DS and P5040 DS
 
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index fbd871e..77fd71f 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -102,6 +102,8 @@ static const char * const boards[] __initconst = {
 	"fsl,P4080DS",
 	"fsl,P5020DS",
 	"fsl,P5040DS",
+	"fsl,T2080QDS",
+	"fsl,T2081QDS",
 	"fsl,T4240QDS",
 	"fsl,B4860QDS",
 	"fsl,B4420QDS",
@@ -115,6 +117,8 @@ static const char * const hv_boards[] __initconst = {
 	"fsl,P4080DS-hv",
 	"fsl,P5020DS-hv",
 	"fsl,P5040DS-hv",
+	"fsl,T2080QDS-hv",
+	"fsl,T2081QDS-hv"
 	"fsl,T4240QDS-hv",
 	"fsl,B4860QDS-hv",
 	"fsl,B4420QDS-hv",
-- 
1.8.0
