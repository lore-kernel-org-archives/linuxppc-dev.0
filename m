Return-Path: <B47053@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0185.outbound.messaging.microsoft.com [213.199.154.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 016212C00CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 20:11:38 +1100 (EST)
From: Xiubo Li <Li.Xiubo@freescale.com>
To: <r65073@freescale.com>, <timur@tabi.org>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>
Subject: [PATCHv1 3/8] ARM: dts: Enables SAI ALSA SoC DAI device for Vybrid
 VF610 TOWER board.
Date: Thu, 17 Oct 2013 17:01:12 +0800
Message-ID: <1382000477-17304-4-git-send-email-Li.Xiubo@freescale.com>
In-Reply-To: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org,
 linux-doc@vger.kernel.org, tiwai@suse.de, b18965@freescale.com, perex@perex.cz,
 LW@KARO-electronics.de, linux@arm.linux.org.uk, b42378@freescale.com,
 oskar@scara.com, grant.likely@linaro.org, devicetree@vger.kernel.org,
 ian.campbell@citrix.com, pawel.moll@arm.com, swarren@wwwdotorg.org,
 rob.herring@calxeda.com, linux-arm-kernel@lists.infradead.org,
 fabio.estevam@freescale.com, linux-kernel@vger.kernel.org, rob@landley.net,
 r64188@freescale.com, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch add and enable SAI device.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 arch/arm/boot/dts/vf610-twr.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index 1a58678..e4106dd 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -57,6 +57,12 @@
 	status = "okay";
 };
 
+&sai2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai2_1>;
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1_1>;
-- 
1.8.0
