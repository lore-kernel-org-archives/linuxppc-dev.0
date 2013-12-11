Return-Path: <Shengzhou.Liu@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 15BA72C0358
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 23:10:16 +1100 (EST)
Received: from mail131-va3 (localhost [127.0.0.1])	by
 mail131-va3-R.bigfish.com (Postfix) with ESMTP id C1A5826019A	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 12:10:11 +0000 (UTC)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH 5/5] powerpc/fsl-booke: Enable T208xQDS board
Date: Wed, 11 Dec 2013 19:19:34 +0800
Message-ID: <1386760774-14743-5-git-send-email-Shengzhou.Liu@freescale.com>
In-Reply-To: <1386760774-14743-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1386760774-14743-1-git-send-email-Shengzhou.Liu@freescale.com>
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
 arch/powerpc/platforms/85xx/Kconfig           | 2 +-
 arch/powerpc/platforms/85xx/corenet_generic.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 4d46349..e3578b7 100644
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
