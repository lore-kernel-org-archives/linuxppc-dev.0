Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl2.internode.on.net (ipmail06.adl2.internode.on.net
 [150.101.137.129]) by ozlabs.org (Postfix) with ESMTP id 6DE2A140128
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 May 2014 18:06:57 +1000 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: benh@kernel.crashing.org
Subject: [PATCH] IBM Akebono: Remove obsolete config select
Date: Fri,  2 May 2014 18:06:45 +1000
Message-Id: <1399018005-23136-1-git-send-email-alistair@popple.id.au>
In-Reply-To: <1398998002.2925.15.camel@pasglop>
References: <1398998002.2925.15.camel@pasglop>
Cc: devicetree@vger.kernel.org, pebolle@tiscali.nl,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Alistair Popple <alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The original implementation of MMC support for Akebono introduced a
new configuration symbol (MMC_SDHCI_OF_476GTR). This symbol has been
dropped in favour of using the generic platform driver however the
select for this symbol was mistakenly left in the platform
configuration.

This patch removes the obsolete symbol selection.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/platforms/44x/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 8beec7d..908bf11 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -220,7 +220,6 @@ config AKEBONO
 	select USB_EHCI_HCD_PLATFORM
 	select MMC_SDHCI
 	select MMC_SDHCI_PLTFM
-	select MMC_SDHCI_OF_476GTR
 	select ATA
 	select SATA_AHCI_PLATFORM
 	help
-- 
1.8.3.2
