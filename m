Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id B736E67B63
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 03:30:31 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k7HHUQ5h011258
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 10:30:26 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k7HHUQRq029481
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 12:30:26 -0500 (CDT)
Subject: Patch] Fix the mpc8641_hpcn.dts file.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1155835482.10054.140.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 17 Aug 2006 12:24:42 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add 'linux,phandle' entry to i8259@4d0 node.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Signed-off-by: Jon Loeliger <jdl@freescale.com>
---

Paul,

If possible, this should be slated for the
upcoming .18 release.

Thanks,
jdl


 arch/powerpc/boot/dts/mpc8641_hpcn.dts |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index e832a88..f0c7731 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -293,6 +293,7 @@
 				f800 0 0 4 4d0 0 0
 				>;
 			i8259@4d0 {
+				linux,phandle = <4d0>;
 				clock-frequency = <0>;
 				interrupt-controller;
 				device_type = "interrupt-controller";
