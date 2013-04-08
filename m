Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews05.kpnxchange.com (cpsmtpb-ews05.kpnxchange.com
 [213.75.39.8]) by ozlabs.org (Postfix) with ESMTP id 24FFF2C00DC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2013 21:27:20 +1000 (EST)
Message-ID: <1365420434.1830.94.camel@x61.thuisdomein>
Subject: [PATCH] powerpc: remove unused "config 405EP"
From: Paul Bolle <pebolle@tiscali.nl>
To: Josh Boyer <jwboyer@gmail.com>, Matt Porter
 <mporter@kernel.crashing.org>,  Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Date: Mon, 08 Apr 2013 13:27:14 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All users of Kconfig symbol 405EP were removed in release v2.6.27.
Remove this symbol (and a useless select of it) too.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
0) Tested by grepping the tree only.

1) There's also a Kconfig symbol EP405. Let's hope no one ever made a
typo with either of these two symbols!

 arch/powerpc/platforms/40x/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
index 7b7a77c..bd40bbb 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -20,7 +20,6 @@ config HOTFOOT
         bool "Hotfoot"
 	depends on 40x
 	default n
-	select 405EP
 	select PPC40x_SIMPLE
 	select PCI
         help
@@ -105,9 +104,6 @@ config 405GP
 	select IBM405_ERR51
 	select IBM_EMAC_ZMII
 
-config 405EP
-	bool
-
 config 405EX
 	bool
 	select IBM_EMAC_EMAC4
-- 
1.7.11.7
