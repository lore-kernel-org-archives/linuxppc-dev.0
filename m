Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews06.kpnxchange.com (cpsmtpb-ews06.kpnxchange.com
 [213.75.39.9]) by ozlabs.org (Postfix) with ESMTP id CEB292C00B4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 00:47:56 +1100 (EST)
Message-ID: <1363268870.1335.75.camel@x61.thuisdomein>
Subject: [PATCH] powerpc/40x: remove unused "config 405GPR"
From: Paul Bolle <pebolle@tiscali.nl>
To: Josh Boyer <jwboyer@gmail.com>, Matt Porter
 <mporter@kernel.crashing.org>,  Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Date: Thu, 14 Mar 2013 14:47:50 +0100
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

The last user of Kconfig symbol 405GPR got removed in release v3.2.
Remove this symbol too.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
 arch/powerpc/platforms/40x/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
index a392d12..7b7a77c 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -119,9 +119,6 @@ config 405EZ
 	select IBM_EMAC_MAL_CLR_ICINTSTAT
 	select IBM_EMAC_MAL_COMMON_ERR
 
-config 405GPR
-	bool
-
 config XILINX_VIRTEX
 	bool
 	select DEFAULT_UIMAGE
-- 
1.7.11.7
