Return-Path: <emillbrandt@norco.coldhaus.com>
From: Eric Millbrandt <emillbrandt@dekaresearch.com>
To: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH] powerpc/pcm030: add pcm030-audio-fabric to dts
Date: Mon, 24 Sep 2012 18:16:47 -0400
Message-Id: <1348525007-14413-1-git-send-email-emillbrandt@dekaresearch.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
 Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a node for the pcm030-audio-fabric ASoC driver

Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>
---
 arch/powerpc/boot/dts/pcm030.dts |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/pcm030.dts b/arch/powerpc/boot/dts/pcm030.dts
index 9e35499..96512c0 100644
--- a/arch/powerpc/boot/dts/pcm030.dts
+++ b/arch/powerpc/boot/dts/pcm030.dts
@@ -59,7 +59,7 @@
 			#gpio-cells = <2>;
 		};
 
-		psc@2000 { /* PSC1 in ac97 mode */
+		audioplatform: psc@2000 { /* PSC1 in ac97 mode */
 			compatible = "mpc5200b-psc-ac97","fsl,mpc5200b-psc-ac97";
 			cell-index = <0>;
 		};
@@ -134,4 +134,9 @@
 	localbus {
 		status = "disabled";
 	};
+
+	sound {
+		compatible = "phytec,pcm030-audio-fabric";
+		asoc-platform = <&audioplatform>;
+	};
 };
-- 
1.7.2.5
