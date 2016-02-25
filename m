Return-Path: <sboyd@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C9A3E1A0B4C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 11:05:26 +1100 (AEDT)
Date: Thu, 25 Feb 2016 15:56:55 -0800
From: Stephen Boyd <sboyd@codeaurora.org>
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>,
 Shawn Guo <shawnguo@kernel.org>
Cc: Anson Huang <b20788@freescale.com>, Arnd Bergmann <arnd@arndb.de>,
 Bai Ping <b51503@freescale.com>,
 Fabio Estevam <fabio.estevam@freescale.com>,
 Frank Li <Frank.Li@freescale.com>, Fugang Duan <B38611@freescale.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Jaroslav Kysela <perex@perex.cz>, Kumar Gala <galak@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>,
 Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Russell King <linux@arm.linux.org.uk>,
 Sascha Hauer <kernel@pengutronix.de>, Takashi Iwai <tiwai@suse.com>,
 Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/2] clk: imx6: add kpp clock for i.MX6UL
Message-ID: <20160225235655.GN28849@codeaurora.org>
References: <1452619759-14474-1-git-send-email-LW@KARO-electronics.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1452619759-14474-1-git-send-email-LW@KARO-electronics.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/12, Lothar Waßmann wrote:
> This patchset adds the clock which is necessary to operate the KPP
> unit on i.MX6UL.
> The first patch removes bogus whitespace before TABs in indentation.
> The second patch adds the clock definition.
> 

Both look fine. Shawn?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
