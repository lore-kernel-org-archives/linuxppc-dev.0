Return-Path: <grant.likely@secretlab.ca>
Date: Thu, 19 Jul 2007 12:37:29 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 2/4] mpc8349: Add linux,network-index to ethernet nodes in
	device tree
In-reply-to: <20070719183415.7458.42622.stgit@trillian>
To: linuxppc-dev@ozlabs.com
Message-id: <20070719183729.7458.41737.stgit@trillian>
Content-type: text/plain; charset=utf-8; format=fixed
References: <20070719183415.7458.42622.stgit@trillian>
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
---

 arch/powerpc/boot/dts/mpc8349emitx.dts   |    2 ++
 arch/powerpc/boot/dts/mpc8349emitxgp.dts |    1 +
 arch/powerpc/boot/dts/mpc834x_mds.dts    |    2 ++
 3 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index ae9bca5..7c13b38 100644
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
index f636528..3c42902 100644
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
index 310e877..13779cd 100644
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
