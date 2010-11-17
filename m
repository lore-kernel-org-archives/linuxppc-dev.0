Return-Path: <bones@secretlab.ca>
Subject: [PATCH 4/5] powerpc/5200: dts: Change combatible strings on localbus
To: linux-kernel@vger.kernel.org
From: John Bonesio <bones@secretlab.ca>
Date: Wed, 17 Nov 2010 15:28:47 -0800
Message-ID: <20101117232847.25947.60171.stgit@riker>
In-Reply-To: <20101117232520.25947.37475.stgit@riker>
References: <20101117232520.25947.37475.stgit@riker>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: glikely@secretlab.ca, jdl@jdl.com, linuxppc-dev@lists.ozlabs.org,
	devicetree-discuss@lists.ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch changes some incorrect compatible strings on the local plus bus node
in dts files for MPC5200b based systems.

Signed-off-by: John Bonesio <bones@secretlab.ca>
---

 arch/powerpc/boot/dts/cm5200.dts    |    2 +-
 arch/powerpc/boot/dts/digsy_mtc.dts |    2 +-
 arch/powerpc/boot/dts/media5200.dts |    2 +-
 arch/powerpc/boot/dts/motionpro.dts |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/cm5200.dts b/arch/powerpc/boot/dts/cm5200.dts
index d549897..22f7233 100644
--- a/arch/powerpc/boot/dts/cm5200.dts
+++ b/arch/powerpc/boot/dts/cm5200.dts
@@ -219,7 +219,7 @@
 	};
 
 	localbus {
-		compatible = "fsl,mpc5200b-lpb","simple-bus";
+		compatible = "fsl,mpc5200b-lpb","fsl,mpc5200-lpb","simple-bus";
 		#address-cells = <2>;
 		#size-cells = <1>;
 		ranges = <0 0 0xfc000000 0x2000000>;
diff --git a/arch/powerpc/boot/dts/digsy_mtc.dts b/arch/powerpc/boot/dts/digsy_mtc.dts
index f0592de..3147b98 100644
--- a/arch/powerpc/boot/dts/digsy_mtc.dts
+++ b/arch/powerpc/boot/dts/digsy_mtc.dts
@@ -218,7 +218,7 @@
 	};
 
 	localbus {
-		compatible = "fsl,mpc5200b-lpb","simple-bus";
+		compatible = "fsl,mpc5200b-lpb","fsl,mpc5200-lpb","simple-bus";
 		#address-cells = <2>;
 		#size-cells = <1>;
 		ranges = <0 0 0xff000000 0x1000000>;
diff --git a/arch/powerpc/boot/dts/media5200.dts b/arch/powerpc/boot/dts/media5200.dts
index e027f45..861f09f 100644
--- a/arch/powerpc/boot/dts/media5200.dts
+++ b/arch/powerpc/boot/dts/media5200.dts
@@ -270,7 +270,7 @@
 	};
 
 	localbus {
-		compatible = "fsl,mpc5200b-lpb","simple-bus";
+		compatible = "fsl,mpc5200b-lpb","fsl,mpc5200-lpb","simple-bus";
 		#address-cells = <2>;
 		#size-cells = <1>;
 
diff --git a/arch/powerpc/boot/dts/motionpro.dts b/arch/powerpc/boot/dts/motionpro.dts
index 3ab4666..97cb085 100644
--- a/arch/powerpc/boot/dts/motionpro.dts
+++ b/arch/powerpc/boot/dts/motionpro.dts
@@ -236,7 +236,7 @@
 	};
 
 	localbus {
-		compatible = "fsl,mpc5200b-lpb","simple-bus";
+		compatible = "fsl,mpc5200b-lpb","fsl,mpc5200-lpb","simple-bus";
 		#address-cells = <2>;
 		#size-cells = <1>;
 		ranges = <0 0 0xff000000 0x01000000
