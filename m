Return-Path: <robherring2@gmail.com>
Received: from mail-ot0-f196.google.com (mail-ot0-f196.google.com
 [74.125.82.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zs9bd4BFZzF1Z0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2018 09:44:12 +1100 (AEDT)
Received: by mail-ot0-f196.google.com with SMTP id h8so3817483oti.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 14:44:12 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: dts: replace 'linux,stdout-path' with 'stdout-path'
Date: Wed, 28 Feb 2018 16:44:06 -0600
Message-Id: <20180228224406.7049-1-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

'linux,stdout-path' has been deprecated for some time in favor of
'stdout-path'. Now dtc will warn on occurrences of 'linux,stdout-path'.
Search and replace all the of occurrences with 'stdout-path'.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/boot/dts/acadia.dts           | 2 +-
 arch/powerpc/boot/dts/adder875-redboot.dts | 2 +-
 arch/powerpc/boot/dts/adder875-uboot.dts   | 2 +-
 arch/powerpc/boot/dts/akebono.dts          | 2 +-
 arch/powerpc/boot/dts/amigaone.dts         | 2 +-
 arch/powerpc/boot/dts/asp834x-redboot.dts  | 2 +-
 arch/powerpc/boot/dts/bamboo.dts           | 2 +-
 arch/powerpc/boot/dts/c2k.dts              | 2 +-
 arch/powerpc/boot/dts/currituck.dts        | 2 +-
 arch/powerpc/boot/dts/ebony.dts            | 2 +-
 arch/powerpc/boot/dts/eiger.dts            | 2 +-
 arch/powerpc/boot/dts/ep405.dts            | 2 +-
 arch/powerpc/boot/dts/fsl/mvme7100.dts     | 2 +-
 arch/powerpc/boot/dts/fsp2.dts             | 2 +-
 arch/powerpc/boot/dts/holly.dts            | 2 +-
 arch/powerpc/boot/dts/hotfoot.dts          | 2 +-
 arch/powerpc/boot/dts/icon.dts             | 2 +-
 arch/powerpc/boot/dts/iss4xx-mpic.dts      | 2 +-
 arch/powerpc/boot/dts/iss4xx.dts           | 2 +-
 arch/powerpc/boot/dts/katmai.dts           | 2 +-
 arch/powerpc/boot/dts/klondike.dts         | 2 +-
 arch/powerpc/boot/dts/ksi8560.dts          | 2 +-
 arch/powerpc/boot/dts/media5200.dts        | 2 +-
 arch/powerpc/boot/dts/mpc8272ads.dts       | 2 +-
 arch/powerpc/boot/dts/mpc866ads.dts        | 2 +-
 arch/powerpc/boot/dts/mpc885ads.dts        | 2 +-
 arch/powerpc/boot/dts/mvme5100.dts         | 2 +-
 arch/powerpc/boot/dts/obs600.dts           | 2 +-
 arch/powerpc/boot/dts/pq2fads.dts          | 2 +-
 arch/powerpc/boot/dts/rainier.dts          | 2 +-
 arch/powerpc/boot/dts/redwood.dts          | 2 +-
 arch/powerpc/boot/dts/sam440ep.dts         | 2 +-
 arch/powerpc/boot/dts/sequoia.dts          | 2 +-
 arch/powerpc/boot/dts/storcenter.dts       | 2 +-
 arch/powerpc/boot/dts/taishan.dts          | 2 +-
 arch/powerpc/boot/dts/virtex440-ml507.dts  | 2 +-
 arch/powerpc/boot/dts/virtex440-ml510.dts  | 2 +-
 arch/powerpc/boot/dts/walnut.dts           | 2 +-
 arch/powerpc/boot/dts/warp.dts             | 2 +-
 arch/powerpc/boot/dts/xpedite5200_xmon.dts | 2 +-
 arch/powerpc/boot/dts/yosemite.dts         | 2 +-
 41 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/arch/powerpc/boot/dts/acadia.dts b/arch/powerpc/boot/dts/acadia.dts
index 86266159521e..deb52e41ab84 100644
--- a/arch/powerpc/boot/dts/acadia.dts
+++ b/arch/powerpc/boot/dts/acadia.dts
@@ -219,6 +219,6 @@
 	};
 
 	chosen {
-		linux,stdout-path = "/plb/opb/serial@ef600300";
+		stdout-path = "/plb/opb/serial@ef600300";
 	};
 };
diff --git a/arch/powerpc/boot/dts/adder875-redboot.dts b/arch/powerpc/boot/dts/adder875-redboot.dts
index 083984720b2f..7f5ff4168482 100644
--- a/arch/powerpc/boot/dts/adder875-redboot.dts
+++ b/arch/powerpc/boot/dts/adder875-redboot.dts
@@ -178,6 +178,6 @@
 	};
 
 	chosen {
-		linux,stdout-path = &console;
+		stdout-path = &console;
 	};
 };
diff --git a/arch/powerpc/boot/dts/adder875-uboot.dts b/arch/powerpc/boot/dts/adder875-uboot.dts
index e4554caf8f8d..bd9f33c57737 100644
--- a/arch/powerpc/boot/dts/adder875-uboot.dts
+++ b/arch/powerpc/boot/dts/adder875-uboot.dts
@@ -177,6 +177,6 @@
 	};
 
 	chosen {
-		linux,stdout-path = &console;
+		stdout-path = &console;
 	};
 };
diff --git a/arch/powerpc/boot/dts/akebono.dts b/arch/powerpc/boot/dts/akebono.dts
index 746779202a12..8a7a10139bc9 100644
--- a/arch/powerpc/boot/dts/akebono.dts
+++ b/arch/powerpc/boot/dts/akebono.dts
@@ -410,6 +410,6 @@
 	};
 
 	chosen {
-		linux,stdout-path = &UART0;
+		stdout-path = &UART0;
 	};
 };
diff --git a/arch/powerpc/boot/dts/amigaone.dts b/arch/powerpc/boot/dts/amigaone.dts
index 49ac36b16dd7..712430155b99 100644
--- a/arch/powerpc/boot/dts/amigaone.dts
+++ b/arch/powerpc/boot/dts/amigaone.dts
@@ -168,6 +168,6 @@
 	};
 
 	chosen {
-		linux,stdout-path = "/pci@80000000/isa@7/serial@3f8";
+		stdout-path = "/pci@80000000/isa@7/serial@3f8";
 	};
 };
diff --git a/arch/powerpc/boot/dts/asp834x-redboot.dts b/arch/powerpc/boot/dts/asp834x-redboot.dts
index 9198745f45fb..e987b5af9326 100644
--- a/arch/powerpc/boot/dts/asp834x-redboot.dts
+++ b/arch/powerpc/boot/dts/asp834x-redboot.dts
@@ -304,7 +304,7 @@
 
 	chosen {
 		bootargs = "console=ttyS0,38400 root=/dev/mtdblock3 rootfstype=jffs2";
-		linux,stdout-path = &serial0;
+		stdout-path = &serial0;
 	};
 
 };
diff --git a/arch/powerpc/boot/dts/bamboo.dts b/arch/powerpc/boot/dts/bamboo.dts
index aa68911f6560..538e42b1120d 100644
--- a/arch/powerpc/boot/dts/bamboo.dts
+++ b/arch/powerpc/boot/dts/bamboo.dts
@@ -295,6 +295,6 @@
 	};
 
 	chosen {
-		linux,stdout-path = "/plb/opb/serial@ef600300";
+		stdout-path = "/plb/opb/serial@ef600300";
 	};
 };
diff --git a/arch/powerpc/boot/dts/c2k.dts b/arch/powerpc/boot/dts/c2k.dts
index 27f169e3ade9..c5beb72d18b7 100644
--- a/arch/powerpc/boot/dts/c2k.dts
+++ b/arch/powerpc/boot/dts/c2k.dts
@@ -361,6 +361,6 @@
 		};
 	};
 	chosen {
-		linux,stdout-path = &MPSC0;
+		stdout-path = &MPSC0;
 	};
 };
diff --git a/arch/powerpc/boot/dts/currituck.dts b/arch/powerpc/boot/dts/currituck.dts
index f2ad5815f08d..a04a4fcfde63 100644
--- a/arch/powerpc/boot/dts/currituck.dts
+++ b/arch/powerpc/boot/dts/currituck.dts
@@ -237,6 +237,6 @@
 	};
 
 	chosen {
-		linux,stdout-path = &UART0;
+		stdout-path = &UART0;
 	};
 };
diff --git a/arch/powerpc/boot/dts/ebony.dts b/arch/powerpc/boot/dts/ebony.dts
index ec2d142291b4..5d11e6ea7405 100644
--- a/arch/powerpc/boot/dts/ebony.dts
+++ b/arch/powerpc/boot/dts/ebony.dts
@@ -332,6 +332,6 @@
 	};
 
 	chosen {
-		linux,stdout-path = "/plb/opb/serial@40000200";
+		stdout-path = "/plb/opb/serial@40000200";
 	};
 };
diff --git a/arch/powerpc/boot/dts/eiger.dts b/arch/powerpc/boot/dts/eiger.dts
index 48bcf7187924..7a1231d9d6f0 100644
--- a/arch/powerpc/boot/dts/eiger.dts
+++ b/arch/powerpc/boot/dts/eiger.dts
@@ -421,7 +421,7 @@
 
 	};
 	chosen {
-		linux,stdout-path = "/plb/opb/serial@ef600200";
+		stdout-path = "/plb/opb/serial@ef600200";
 	};
 
 };
diff --git a/arch/powerpc/boot/dts/ep405.dts b/arch/powerpc/boot/dts/ep405.dts
index 53ef06cc2134..4ac9c5ab6e6b 100644
--- a/arch/powerpc/boot/dts/ep405.dts
+++ b/arch/powerpc/boot/dts/ep405.dts
@@ -225,6 +225,6 @@
 	};
 
 	chosen {
-		linux,stdout-path = "/plb/opb/serial@ef600300";
+		stdout-path = "/plb/opb/serial@ef600300";
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/mvme7100.dts b/arch/powerpc/boot/dts/fsl/mvme7100.dts
index e2d306ad37a6..721cb53758ae 100644
--- a/arch/powerpc/boot/dts/fsl/mvme7100.dts
+++ b/arch/powerpc/boot/dts/fsl/mvme7100.dts
@@ -146,7 +146,7 @@
 	};
 
 	chosen {
-		linux,stdout-path = &serial0;
+		stdout-path = &serial0;
 	};
 };
 
diff --git a/arch/powerpc/boot/dts/fsp2.dts b/arch/powerpc/boot/dts/fsp2.dts
index 6560283c5aec..9311b86b1bd9 100644
--- a/arch/powerpc/boot/dts/fsp2.dts
+++ b/arch/powerpc/boot/dts/fsp2.dts
@@ -607,7 +607,7 @@
 	};
 
 	chosen {
-		linux,stdout-path = "/plb/opb/serial@b0020000";
+		stdout-path = "/plb/opb/serial@b0020000";
 		bootargs = "console=ttyS0,115200 rw log_buf_len=32768 debug";
 	};
 };
diff --git a/arch/powerpc/boot/dts/holly.dts b/arch/powerpc/boot/dts/holly.dts
index 43e6f0c8e449..02bd304c7d38 100644
--- a/arch/powerpc/boot/dts/holly.dts
+++ b/arch/powerpc/boot/dts/holly.dts
@@ -191,6 +191,6 @@
 	};
 
 	chosen {
-		linux,stdout-path = "/tsi109@c0000000/serial@7808";
+		stdout-path = "/tsi109@c0000000/serial@7808";
 	};
 };
diff --git a/arch/powerpc/boot/dts/hotfoot.dts b/arch/powerpc/boot/dts/hotfoot.dts
index 71d3bb4931dc..b93bf2d9dd5b 100644
--- a/arch/powerpc/boot/dts/hotfoot.dts
+++ b/arch/powerpc/boot/dts/hotfoot.dts
@@ -291,6 +291,6 @@
 	};
 
 	chosen {
-		linux,stdout-path = &UART0;
+		stdout-path = &UART0;
 	};
 };
diff --git a/arch/powerpc/boot/dts/icon.dts b/arch/powerpc/boot/dts/icon.dts
index 9c94fd737f7c..2e6e3a7b2604 100644
--- a/arch/powerpc/boot/dts/icon.dts
+++ b/arch/powerpc/boot/dts/icon.dts
@@ -442,6 +442,6 @@
 	};
 
 	chosen {
-		linux,stdout-path = "/plb/opb/serial@f0000200";
+		stdout-path = "/plb/opb/serial@f0000200";
 	};
 };
diff --git a/arch/powerpc/boot/dts/iss4xx-mpic.dts b/arch/powerpc/boot/dts/iss4xx-mpic.dts
index 23e9d9b7e400..f7063198b2dc 100644
--- a/arch/powerpc/boot/dts/iss4xx-mpic.dts
+++ b/arch/powerpc/boot/dts/iss4xx-mpic.dts
@@ -150,6 +150,6 @@
 	};
 
 	chosen {
-		linux,stdout-path = "/plb/opb/serial@40000200";
+		stdout-path = "/plb/opb/serial@40000200";
 	};
 };
diff --git a/arch/powerpc/boot/dts/iss4xx.dts b/arch/powerpc/boot/dts/iss4xx.dts
index 4ff6555c866d..5533aff25e41 100644
--- a/arch/powerpc/boot/dts/iss4xx.dts
+++ b/arch/powerpc/boot/dts/iss4xx.dts
@@ -111,6 +111,6 @@
 	};
 
 	chosen {
-		linux,stdout-path = "/plb/opb/serial@40000200";
+		stdout-path = "/plb/opb/serial@40000200";
 	};
 };
diff --git a/arch/powerpc/boot/dts/katmai.dts b/arch/powerpc/boot/dts/katmai.dts
index f913dbe25d35..02629e119b87 100644
--- a/arch/powerpc/boot/dts/katmai.dts
+++ b/arch/powerpc/boot/dts/katmai.dts
@@ -505,6 +505,6 @@
 	};
 
 	chosen {
-		linux,stdout-path = "/plb/opb/serial@f0000200";
+		stdout-path = "/plb/opb/serial@f0000200";
 	};
 };
diff --git a/arch/powerpc/boot/dts/klondike.dts b/arch/powerpc/boot/dts/klondike.dts
index 8c9429033618..d9613b7b945f 100644
--- a/arch/powerpc/boot/dts/klondike.dts
+++ b/arch/powerpc/boot/dts/klondike.dts
@@ -222,6 +222,6 @@
 	};
 
 	chosen {
-		linux,stdout-path = "/plb/opb/serial@50001000";
+		stdout-path = "/plb/opb/serial@50001000";
 	};
 };
diff --git a/arch/powerpc/boot/dts/ksi8560.dts b/arch/powerpc/boot/dts/ksi8560.dts
index 5d68236e7c3c..fe6c17c8812a 100644
--- a/arch/powerpc/boot/dts/ksi8560.dts
+++ b/arch/powerpc/boot/dts/ksi8560.dts
@@ -339,6 +339,6 @@
 
 
 	chosen {
-		linux,stdout-path = "/soc/cpm/serial@91a00";
+		stdout-path = "/soc/cpm/serial@91a00";
 	};
 };
diff --git a/arch/powerpc/boot/dts/media5200.dts b/arch/powerpc/boot/dts/media5200.dts
index b5413cb85f13..843f156a49c4 100644
--- a/arch/powerpc/boot/dts/media5200.dts
+++ b/arch/powerpc/boot/dts/media5200.dts
@@ -25,7 +25,7 @@
 	};
 
 	chosen {
-		linux,stdout-path = &console;
+		stdout-path = &console;
 	};
 
 	cpus {
diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
index 6d2cddf64cfd..98282c18d989 100644
--- a/arch/powerpc/boot/dts/mpc8272ads.dts
+++ b/arch/powerpc/boot/dts/mpc8272ads.dts
@@ -262,6 +262,6 @@
 	};
 
 	chosen {
-		linux,stdout-path = "/soc/cpm/serial@11a00";
+		stdout-path = "/soc/cpm/serial@11a00";
 	};
 };
diff --git a/arch/powerpc/boot/dts/mpc866ads.dts b/arch/powerpc/boot/dts/mpc866ads.dts
index 34c1f48b1a09..4443fac3f576 100644
--- a/arch/powerpc/boot/dts/mpc866ads.dts
+++ b/arch/powerpc/boot/dts/mpc866ads.dts
@@ -185,6 +185,6 @@
 	};
 
 	chosen {
-		linux,stdout-path = "/soc/cpm/serial@a80";
+		stdout-path = "/soc/cpm/serial@a80";
 	};
 };
diff --git a/arch/powerpc/boot/dts/mpc885ads.dts b/arch/powerpc/boot/dts/mpc885ads.dts
index 4e93bd961e0f..5b037f51741d 100644
--- a/arch/powerpc/boot/dts/mpc885ads.dts
+++ b/arch/powerpc/boot/dts/mpc885ads.dts
@@ -227,6 +227,6 @@
 	};
 
 	chosen {
-		linux,stdout-path = "/soc/cpm/serial@a80";
+		stdout-path = "/soc/cpm/serial@a80";
 	};
 };
diff --git a/arch/powerpc/boot/dts/mvme5100.dts b/arch/powerpc/boot/dts/mvme5100.dts
index 1ecb341a232a..a7eb6d25903d 100644
--- a/arch/powerpc/boot/dts/mvme5100.dts
+++ b/arch/powerpc/boot/dts/mvme5100.dts
@@ -179,7 +179,7 @@
 	};
 
 	chosen {
-		linux,stdout-path = &serial0;
+		stdout-path = &serial0;
         };
 
 };
diff --git a/arch/powerpc/boot/dts/obs600.dts b/arch/powerpc/boot/dts/obs600.dts
index 18e7d79ee4c3..d10b0411809b 100644
--- a/arch/powerpc/boot/dts/obs600.dts
+++ b/arch/powerpc/boot/dts/obs600.dts
@@ -309,6 +309,6 @@
 		};
 	};
         chosen {
-                linux,stdout-path = "/plb/opb/serial@ef600200";
+                stdout-path = "/plb/opb/serial@ef600200";
         };
 };
diff --git a/arch/powerpc/boot/dts/pq2fads.dts b/arch/powerpc/boot/dts/pq2fads.dts
index 0c525ff0c257..a477615e3468 100644
--- a/arch/powerpc/boot/dts/pq2fads.dts
+++ b/arch/powerpc/boot/dts/pq2fads.dts
@@ -242,6 +242,6 @@
 	};
 
 	chosen {
-		linux,stdout-path = "/soc/cpm/serial@11a00";
+		stdout-path = "/soc/cpm/serial@11a00";
 	};
 };
diff --git a/arch/powerpc/boot/dts/rainier.dts b/arch/powerpc/boot/dts/rainier.dts
index 9684c80e4093..e59829cff556 100644
--- a/arch/powerpc/boot/dts/rainier.dts
+++ b/arch/powerpc/boot/dts/rainier.dts
@@ -344,7 +344,7 @@
 	};
 
 	chosen {
-		linux,stdout-path = "/plb/opb/serial@ef600300";
+		stdout-path = "/plb/opb/serial@ef600300";
 		bootargs = "console=ttyS0,115200";
 	};
 };
diff --git a/arch/powerpc/boot/dts/redwood.dts b/arch/powerpc/boot/dts/redwood.dts
index d86a3a498118..f3e046fb49e2 100644
--- a/arch/powerpc/boot/dts/redwood.dts
+++ b/arch/powerpc/boot/dts/redwood.dts
@@ -381,7 +381,7 @@
 
 
 	chosen {
-		linux,stdout-path = "/plb/opb/serial@ef600200";
+		stdout-path = "/plb/opb/serial@ef600200";
 	};
 
 };
diff --git a/arch/powerpc/boot/dts/sam440ep.dts b/arch/powerpc/boot/dts/sam440ep.dts
index 088361cf4636..7d15f18e1180 100644
--- a/arch/powerpc/boot/dts/sam440ep.dts
+++ b/arch/powerpc/boot/dts/sam440ep.dts
@@ -288,6 +288,6 @@
 	};
 
 	chosen {
-		linux,stdout-path = "/plb/opb/serial@ef600300";
+		stdout-path = "/plb/opb/serial@ef600300";
 	};
 };
diff --git a/arch/powerpc/boot/dts/sequoia.dts b/arch/powerpc/boot/dts/sequoia.dts
index e41b88a5eaee..60d211da9593 100644
--- a/arch/powerpc/boot/dts/sequoia.dts
+++ b/arch/powerpc/boot/dts/sequoia.dts
@@ -406,7 +406,7 @@
 	};
 
 	chosen {
-		linux,stdout-path = "/plb/opb/serial@ef600300";
+		stdout-path = "/plb/opb/serial@ef600300";
 		bootargs = "console=ttyS0,115200";
 	};
 };
diff --git a/arch/powerpc/boot/dts/storcenter.dts b/arch/powerpc/boot/dts/storcenter.dts
index 2a555738517e..99f6f544dc5f 100644
--- a/arch/powerpc/boot/dts/storcenter.dts
+++ b/arch/powerpc/boot/dts/storcenter.dts
@@ -137,6 +137,6 @@
 	};
 
 	chosen {
-		linux,stdout-path = &serial0;
+		stdout-path = &serial0;
 	};
 };
diff --git a/arch/powerpc/boot/dts/taishan.dts b/arch/powerpc/boot/dts/taishan.dts
index 1657ad0bf8a6..803f1bff7fa8 100644
--- a/arch/powerpc/boot/dts/taishan.dts
+++ b/arch/powerpc/boot/dts/taishan.dts
@@ -422,6 +422,6 @@
 	};
 
 	chosen {
-		linux,stdout-path = "/plb/opb/serial@40000300";
+		stdout-path = "/plb/opb/serial@40000300";
 	};
 };
diff --git a/arch/powerpc/boot/dts/virtex440-ml507.dts b/arch/powerpc/boot/dts/virtex440-ml507.dts
index 391a4e299783..66f1c6312de6 100644
--- a/arch/powerpc/boot/dts/virtex440-ml507.dts
+++ b/arch/powerpc/boot/dts/virtex440-ml507.dts
@@ -32,7 +32,7 @@
 	} ;
 	chosen {
 		bootargs = "console=ttyS0 root=/dev/ram";
-		linux,stdout-path = &RS232_Uart_1;
+		stdout-path = &RS232_Uart_1;
 	} ;
 	cpus {
 		#address-cells = <1>;
diff --git a/arch/powerpc/boot/dts/virtex440-ml510.dts b/arch/powerpc/boot/dts/virtex440-ml510.dts
index 81201d3907e2..3b736ca26ddc 100644
--- a/arch/powerpc/boot/dts/virtex440-ml510.dts
+++ b/arch/powerpc/boot/dts/virtex440-ml510.dts
@@ -26,7 +26,7 @@
 	} ;
 	chosen {
 		bootargs = "console=ttyS0 root=/dev/ram";
-		linux,stdout-path = "/plb@0/serial@83e00000";
+		stdout-path = "/plb@0/serial@83e00000";
 	} ;
 	cpus {
 		#address-cells = <1>;
diff --git a/arch/powerpc/boot/dts/walnut.dts b/arch/powerpc/boot/dts/walnut.dts
index 4a9f726ada13..0872862c9363 100644
--- a/arch/powerpc/boot/dts/walnut.dts
+++ b/arch/powerpc/boot/dts/walnut.dts
@@ -241,6 +241,6 @@
 	};
 
 	chosen {
-		linux,stdout-path = "/plb/opb/serial@ef600300";
+		stdout-path = "/plb/opb/serial@ef600300";
 	};
 };
diff --git a/arch/powerpc/boot/dts/warp.dts b/arch/powerpc/boot/dts/warp.dts
index ea9053ef4819..b4f32740870e 100644
--- a/arch/powerpc/boot/dts/warp.dts
+++ b/arch/powerpc/boot/dts/warp.dts
@@ -304,6 +304,6 @@
 	};
 
 	chosen {
-		linux,stdout-path = "/plb/opb/serial@ef600300";
+		stdout-path = "/plb/opb/serial@ef600300";
 	};
 };
diff --git a/arch/powerpc/boot/dts/xpedite5200_xmon.dts b/arch/powerpc/boot/dts/xpedite5200_xmon.dts
index 646acfbef0dd..d5e14421c39a 100644
--- a/arch/powerpc/boot/dts/xpedite5200_xmon.dts
+++ b/arch/powerpc/boot/dts/xpedite5200_xmon.dts
@@ -503,6 +503,6 @@
 
 	/* Needed for dtbImage boot wrapper compatibility */
 	chosen {
-		linux,stdout-path = &serial0;
+		stdout-path = &serial0;
 	};
 };
diff --git a/arch/powerpc/boot/dts/yosemite.dts b/arch/powerpc/boot/dts/yosemite.dts
index 30bb4753577a..56508785ce13 100644
--- a/arch/powerpc/boot/dts/yosemite.dts
+++ b/arch/powerpc/boot/dts/yosemite.dts
@@ -327,6 +327,6 @@
 	};
 
 	chosen {
-		linux,stdout-path = "/plb/opb/serial@ef600300";
+		stdout-path = "/plb/opb/serial@ef600300";
 	};
 };
-- 
2.14.1
