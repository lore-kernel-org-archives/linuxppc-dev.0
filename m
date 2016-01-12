Return-Path: <LW@KARO-electronics.de>
Received: from mail.karo-electronics.de (mail.karo-electronics.de
 [81.173.242.67]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ACBF1A17E0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 04:48:07 +1100 (AEDT)
From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
To: Anson Huang <b20788@freescale.com>, Arnd Bergmann <arnd@arndb.de>,
 Bai Ping <b51503@freescale.com>,
 Fabio Estevam <fabio.estevam@freescale.com>,
 Frank Li <Frank.Li@freescale.com>, Fugang Duan <B38611@freescale.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Jaroslav Kysela <perex@perex.cz>, Kumar Gala <galak@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Pawel Moll <pawel.moll@arm.com>,
 Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>,
 Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Stephen Boyd <sboyd@codeaurora.org>, Takashi Iwai <tiwai@suse.com>,
 Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCH 0/2] clk: imx6: add kpp clock for i.MX6UL
Date: Tue, 12 Jan 2016 18:29:17 +0100
Message-Id: <1452619759-14474-1-git-send-email-LW@KARO-electronics.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset adds the clock which is necessary to operate the KPP
unit on i.MX6UL.
The first patch removes bogus whitespace before TABs in indentation.
The second patch adds the clock definition.
