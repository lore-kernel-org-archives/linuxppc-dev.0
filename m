Return-Path: <grant.likely@secretlab.ca>
Received: from pd4mo3so.prod.shaw.ca (shawidc-mo1.cg.shawcable.net
	[24.71.223.10]) by ozlabs.org (Postfix) with ESMTP id C61CFDDECE
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 06:28:17 +1000 (EST)
Received: from pd3mr5so.prod.shaw.ca (pd3mr5so-qfe3.prod.shaw.ca [10.0.141.12])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JNL00GGGSS2DP00@l-daemon> for linuxppc-dev@ozlabs.org;
	Thu, 30 Aug 2007 14:26:26 -0600 (MDT)
Received: from pn2ml5so.prod.shaw.ca ([10.0.121.149])
	by pd3mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JNL00FAKSS1H670@pd3mr5so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Thu, 30 Aug 2007 14:26:26 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JNL001LOSRYXJ51@l-daemon> for linuxppc-dev@ozlabs.org;
	Thu, 30 Aug 2007 14:26:22 -0600 (MDT)
Date: Thu, 30 Aug 2007 14:26:24 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 2/3] mpc8349: Add linux,
	network-index to ethernet nodes in device tree
In-reply-to: <20070830202618.9927.32588.stgit@trillian.cg.shawcable.net>
To: linuxppc-dev@ozlabs.org
Message-id: <20070830202624.9927.50088.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20070830202618.9927.32588.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

cuImage need to know the logical index of the ethernet devices in order
to assign mac addresses.  This patch adds the needed properties

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
CC: Scott Wood <scottwood@freescale.com>
CC: Kumar Gala <galak@kernel.crashing.org>
CC: Timur Tabi <timur@freescale.com>
---

 arch/powerpc/boot/dts/mpc8349emitx.dts   |    2 ++
 arch/powerpc/boot/dts/mpc8349emitxgp.dts |    1 +
 arch/powerpc/boot/dts/mpc834x_mds.dts    |    2 ++
 3 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 502f47c..a4e2284 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -141,6 +141,7 @@
 			interrupts = <20 8 21 8 22 8>;
 			interrupt-parent = < &ipic >;
 			phy-handle = < &phy1c >;
+			linux,network-index = <0>;
 		};
 
 		ethernet@25000 {
@@ -160,6 +161,7 @@
 			interrupts = <23 8 24 8 25 8>;
 			interrupt-parent = < &ipic >;
 			phy-handle = < &phy1f >;
+			linux,network-index = <1>;
 		};
 
 		serial@4500 {
diff --git a/arch/powerpc/boot/dts/mpc8349emitxgp.dts b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
index 0b83871..004b737 100644
--- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
@@ -116,6 +116,7 @@
 			interrupts = <20 8 21 8 22 8>;
 			interrupt-parent = < &ipic >;
 			phy-handle = < &phy1c >;
+			linux,network-index = <0>;
 		};
 
 		serial@4500 {
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index 4810997..251c233 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -146,6 +146,7 @@
 			interrupts = <20 8 21 8 22 8>;
 			interrupt-parent = < &ipic >;
 			phy-handle = < &phy0 >;
+			linux,network-index = <0>;
 		};
 
 		ethernet@25000 {
@@ -165,6 +166,7 @@
 			interrupts = <23 8 24 8 25 8>;
 			interrupt-parent = < &ipic >;
 			phy-handle = < &phy1 >;
+			linux,network-index = <1>;
 		};
 
 		serial@4500 {
