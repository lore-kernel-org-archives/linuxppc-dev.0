Return-Path: <R1AAHA@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 19A1FB7D40
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Apr 2010 10:13:39 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3N0Dbig004053
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Apr 2010 17:13:37 -0700 (MST)
Received: from az33exm22.fsl.freescale.net (az33exm22.am.freescale.net
	[10.64.32.10])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o3N0LpDr027692
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Apr 2010 19:21:51 -0500 (CDT)
Date: Thu, 22 Apr 2010 19:25:13 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: remove tls_ssl_stream descriptor type capability
	in sec3.3 node
Message-Id: <20100422192513.27ce5356.kim.phillips@freescale.com>
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

Technically, whilst SEC v3.3 h/w honours the tls_ssl_stream descriptor
type, it lacks the ARC4 algorithm execution unit required to be able
to execute anything meaningful with it.  Change the node to agree with
the documentation that declares that the sec3.3 really doesn't have such
a descriptor type.

Reported-by: Haiying Wang <Haiying.Wang@freescale.com>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/boot/dts/mpc8315erdb.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8315erdb.dts b/arch/powerpc/boot/dts/mpc8315erdb.dts
index 8a3a4f3..508b770 100644
--- a/arch/powerpc/boot/dts/mpc8315erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8315erdb.dts
@@ -292,7 +292,7 @@
 			fsl,num-channels = <4>;
 			fsl,channel-fifo-len = <24>;
 			fsl,exec-units-mask = <0x97c>;
-			fsl,descriptor-types-mask = <0x3ab0abf>;
+			fsl,descriptor-types-mask = <0x3a30abf>;
 		};
 
 		sata@18000 {
-- 
1.7.0.5
