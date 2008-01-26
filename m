Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 23689DDE0C
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 17:54:55 +1100 (EST)
Message-ID: <479AD93D.30202@pikatech.com>
Date: Sat, 26 Jan 2008 01:54:53 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH]  FIXED_MII_100_FDX
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On the last git pull,  FIXED_MII_100_FDX was removed from the phy 
Kconfig, but the Kconfig for CPMAC still tried to select it.

Cheers,
   Sean

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 9af05a2..297a4b5 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1710,7 +1710,6 @@ config CPMAC
 	depends on NET_ETHERNET && EXPERIMENTAL && AR7
 	select PHYLIB
 	select FIXED_PHY
-	select FIXED_MII_100_FDX
 	help
 	  TI AR7 CPMAC Ethernet support
 
