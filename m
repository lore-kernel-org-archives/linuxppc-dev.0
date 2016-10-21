Return-Path: <geert@linux-m68k.org>
Received: from leibniz.telenet-ops.be (leibniz.telenet-ops.be
 [IPv6:2a02:1800:110:4::f00:d])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0fhm36gNzDvZy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 19:58:00 +1100 (AEDT)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be
 [IPv6:2a02:1800:110:4::f00:19])
 by leibniz.telenet-ops.be (Postfix) with ESMTPS id 3t0fY90m5jzMr0wn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 10:51:25 +0200 (CEST)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Patrice Chotard <patrice.chotard@st.com>, Chanho Min <chanho.min@lge.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-arm-kernel@lists.infradead.org, kernel@stlinux.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/6] ARM: dts: STiH407: DT fix
 s/interrupts-names/interrupt-names/
Date: Fri, 21 Oct 2016 10:51:12 +0200
Message-Id: <1477039877-20227-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1477039877-20227-1-git-send-email-geert+renesas@glider.be>
References: <1477039877-20227-1-git-send-email-geert+renesas@glider.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
---
v2:
  - Add Acked-by.
---
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index c325cc059ae4bc80..daab16b5ae645cee 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -1157,7 +1157,7 @@
 			reg = <0x0923f080 0x4>;
 			reg-names = "irqmux";
 			interrupts = <GIC_SPI 192 IRQ_TYPE_NONE>;
-			interrupts-names = "irqmux";
+			interrupt-names = "irqmux";
 			ranges = <0 0x09230000 0x3000>;
 
 			pio40: gpio@09230000 {
-- 
1.9.1
