Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2l6W0tJYzDsyC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 05:24:02 +1100 (AEDT)
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Patrice Chotard <patrice.chotard@st.com>, Chanho Min <chanho.min@lge.com>,
 Michael Ellerman <mpe@ellerman.id.au>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, kernel@stlinux.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <1477039877-20227-5-git-send-email-geert+renesas@glider.be>
Message-Id: <E1byjbu-0001Tg-U9@debutante>
Date: Mon, 24 Oct 2016 19:04:34 +0100
Subject: Applied "ASoC: davinci-mcbsp: DT fix
 s/interrupts-names/interrupt-names/" to the asoc tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: davinci-mcbsp: DT fix s/interrupts-names/interrupt-names/

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From a545f5d859c7988ab61850395a4565bfe507dc0a Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 21 Oct 2016 10:51:15 +0200
Subject: [PATCH] ASoC: davinci-mcbsp: DT fix
 s/interrupts-names/interrupt-names/

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/davinci-mcbsp.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt b/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
index 55b53e1fd72c..e0b6165c9cfc 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
@@ -43,7 +43,7 @@ mcbsp0: mcbsp@1d10000 {
 		<0x00310000 0x1000>;
 	reg-names = "mpu", "dat";
 	interrupts = <97 98>;
-	interrupts-names = "rx", "tx";
+	interrupt-names = "rx", "tx";
 	dmas = <&edma0 3 1
 		&edma0 2 1>;
 	dma-names = "tx", "rx";
-- 
2.8.1
