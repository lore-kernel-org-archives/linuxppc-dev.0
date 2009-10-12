Return-Path: <Kim.Phillips@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 44870B7BB7
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2009 03:35:30 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n9CGZSBl012729
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2009 09:35:28 -0700 (MST)
Received: from az33exm22.fsl.freescale.net (az33exm22.am.freescale.net
	[10.64.32.10])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n9CGZSWv024429
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2009 11:35:28 -0500 (CDT)
Date: Mon, 12 Oct 2009 11:35:27 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/8xxx: enable IPsec ESP by default on mpc83xx/mpc85xx
Message-Id: <20091012113527.a822b6b4.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/configs/mpc83xx_defconfig     |   15 ++++++++-------
 arch/powerpc/configs/mpc85xx_defconfig     |   16 ++++++++--------
 arch/powerpc/configs/mpc85xx_smp_defconfig |   16 ++++++++--------
 3 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/configs/mpc83xx_defconfig b/arch/powerpc/configs/mpc83xx_defconfig
index 4a96cb6..d6d28f2 100644
--- a/arch/powerpc/configs/mpc83xx_defconfig
+++ b/arch/powerpc/configs/mpc83xx_defconfig
@@ -343,7 +343,8 @@ CONFIG_XFRM_USER=m
 # CONFIG_XFRM_SUB_POLICY is not set
 # CONFIG_XFRM_MIGRATE is not set
 # CONFIG_XFRM_STATISTICS is not set
-# CONFIG_NET_KEY is not set
+CONFIG_NET_KEY=y
+# CONFIG_NET_KEY_MIGRATE is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 # CONFIG_IP_ADVANCED_ROUTER is not set
@@ -358,7 +359,7 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_ARPD is not set
 CONFIG_SYN_COOKIES=y
 # CONFIG_INET_AH is not set
-# CONFIG_INET_ESP is not set
+CONFIG_INET_ESP=y
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_INET_XFRM_TUNNEL is not set
 # CONFIG_INET_TUNNEL is not set
@@ -1591,7 +1592,7 @@ CONFIG_CRYPTO_PCBC=m
 #
 # Hash modes
 #
-# CONFIG_CRYPTO_HMAC is not set
+CONFIG_CRYPTO_HMAC=y
 # CONFIG_CRYPTO_XCBC is not set
 
 #
@@ -1605,16 +1606,16 @@ CONFIG_CRYPTO_MD5=y
 # CONFIG_CRYPTO_RMD160 is not set
 # CONFIG_CRYPTO_RMD256 is not set
 # CONFIG_CRYPTO_RMD320 is not set
-# CONFIG_CRYPTO_SHA1 is not set
-# CONFIG_CRYPTO_SHA256 is not set
-# CONFIG_CRYPTO_SHA512 is not set
+CONFIG_CRYPTO_SHA1=y
+CONFIG_CRYPTO_SHA256=y
+CONFIG_CRYPTO_SHA512=y
 # CONFIG_CRYPTO_TGR192 is not set
 # CONFIG_CRYPTO_WP512 is not set
 
 #
 # Ciphers
 #
-# CONFIG_CRYPTO_AES is not set
+CONFIG_CRYPTO_AES=y
 # CONFIG_CRYPTO_ANUBIS is not set
 # CONFIG_CRYPTO_ARC4 is not set
 # CONFIG_CRYPTO_BLOWFISH is not set
diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index ada5958..35f941c 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -344,7 +344,7 @@ CONFIG_XFRM_USER=y
 # CONFIG_XFRM_SUB_POLICY is not set
 # CONFIG_XFRM_MIGRATE is not set
 # CONFIG_XFRM_STATISTICS is not set
-CONFIG_NET_KEY=m
+CONFIG_NET_KEY=y
 # CONFIG_NET_KEY_MIGRATE is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -368,12 +368,12 @@ CONFIG_IP_PIMSM_V2=y
 CONFIG_ARPD=y
 # CONFIG_SYN_COOKIES is not set
 # CONFIG_INET_AH is not set
-# CONFIG_INET_ESP is not set
+CONFIG_INET_ESP=y
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_INET_XFRM_TUNNEL is not set
 CONFIG_INET_TUNNEL=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
 # CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_LRO is not set
 CONFIG_INET_DIAG=y
@@ -1768,16 +1768,16 @@ CONFIG_CRYPTO_MD5=y
 # CONFIG_CRYPTO_RMD160 is not set
 # CONFIG_CRYPTO_RMD256 is not set
 # CONFIG_CRYPTO_RMD320 is not set
-CONFIG_CRYPTO_SHA1=m
-# CONFIG_CRYPTO_SHA256 is not set
-# CONFIG_CRYPTO_SHA512 is not set
+CONFIG_CRYPTO_SHA1=y
+CONFIG_CRYPTO_SHA256=y
+CONFIG_CRYPTO_SHA512=y
 # CONFIG_CRYPTO_TGR192 is not set
 # CONFIG_CRYPTO_WP512 is not set
 
 #
 # Ciphers
 #
-# CONFIG_CRYPTO_AES is not set
+CONFIG_CRYPTO_AES=y
 # CONFIG_CRYPTO_ANUBIS is not set
 # CONFIG_CRYPTO_ARC4 is not set
 # CONFIG_CRYPTO_BLOWFISH is not set
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index db082ce..ab45fd9 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -348,7 +348,7 @@ CONFIG_XFRM_USER=y
 # CONFIG_XFRM_SUB_POLICY is not set
 # CONFIG_XFRM_MIGRATE is not set
 # CONFIG_XFRM_STATISTICS is not set
-CONFIG_NET_KEY=m
+CONFIG_NET_KEY=y
 # CONFIG_NET_KEY_MIGRATE is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -372,12 +372,12 @@ CONFIG_IP_PIMSM_V2=y
 CONFIG_ARPD=y
 # CONFIG_SYN_COOKIES is not set
 # CONFIG_INET_AH is not set
-# CONFIG_INET_ESP is not set
+CONFIG_INET_ESP=y
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_INET_XFRM_TUNNEL is not set
 CONFIG_INET_TUNNEL=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
 # CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_LRO is not set
 CONFIG_INET_DIAG=y
@@ -1772,16 +1772,16 @@ CONFIG_CRYPTO_MD5=y
 # CONFIG_CRYPTO_RMD160 is not set
 # CONFIG_CRYPTO_RMD256 is not set
 # CONFIG_CRYPTO_RMD320 is not set
-CONFIG_CRYPTO_SHA1=m
-# CONFIG_CRYPTO_SHA256 is not set
-# CONFIG_CRYPTO_SHA512 is not set
+CONFIG_CRYPTO_SHA1=y
+CONFIG_CRYPTO_SHA256=y
+CONFIG_CRYPTO_SHA512=y
 # CONFIG_CRYPTO_TGR192 is not set
 # CONFIG_CRYPTO_WP512 is not set
 
 #
 # Ciphers
 #
-# CONFIG_CRYPTO_AES is not set
+CONFIG_CRYPTO_AES=y
 # CONFIG_CRYPTO_ANUBIS is not set
 # CONFIG_CRYPTO_ARC4 is not set
 # CONFIG_CRYPTO_BLOWFISH is not set
-- 
1.6.4.4
