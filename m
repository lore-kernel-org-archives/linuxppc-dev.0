Return-Path: <alessio.bogani@elettra.eu>
Received: from elettra.eu (m2.elettra.trieste.it [140.105.206.202])
 by lists.ozlabs.org (Postfix) with ESMTP id B13881A0BBB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 20:23:37 +1100 (AEDT)
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: Scott Wood <scottwood@freescale.com>,
 Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc: dts: pq3/85xx: Fix GPIO address
Date: Thu,  4 Dec 2014 10:23:11 +0100
Message-Id: <1417684991-1574-1-git-send-email-alessio.bogani@elettra.eu>
Cc: Alessio Igor Bogani <alessio.bogani@elettra.eu>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix the GPIO address in the device tree to match the documented location.

Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
---
 arch/powerpc/boot/dts/fsl/pq3-gpio-0.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/pq3-gpio-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-gpio-0.dtsi
index 72a3ef5..a1b4854 100644
--- a/arch/powerpc/boot/dts/fsl/pq3-gpio-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/pq3-gpio-0.dtsi
@@ -1,5 +1,5 @@
 /*
- * PQ3 GPIO device tree stub [ controller @ offset 0xf000 ]
+ * PQ3 GPIO device tree stub [ controller @ offset 0xfc00 ]
  *
  * Copyright 2011 Freescale Semiconductor Inc.
  *
@@ -32,10 +32,10 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-gpio-controller@f000 {
+gpio-controller@fc00 {
 	#gpio-cells = <2>;
 	compatible = "fsl,pq3-gpio";
-	reg = <0xf000 0x100>;
+	reg = <0xfc00 0x100>;
 	interrupts = <47 0x2 0 0>;
 	gpio-controller;
 };
-- 
2.1.3
