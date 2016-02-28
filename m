Return-Path: <shawnguo@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D8C7C1A0B50
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Feb 2016 13:51:33 +1100 (AEDT)
Date: Sun, 28 Feb 2016 10:51:07 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>,
 Anson Huang <b20788@freescale.com>, Arnd Bergmann <arnd@arndb.de>,
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
Message-ID: <20160228025107.GC22051@tiger>
References: <1452619759-14474-1-git-send-email-LW@KARO-electronics.de>
 <20160225235655.GN28849@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20160225235655.GN28849@codeaurora.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 25, 2016 at 03:56:55PM -0800, Stephen Boyd wrote:
> On 01/12, Lothar Waßmann wrote:
> > This patchset adds the clock which is necessary to operate the KPP
> > unit on i.MX6UL.
> > The first patch removes bogus whitespace before TABs in indentation.
> > The second patch adds the clock definition.
> > 
> 
> Both look fine. Shawn?

Oops, the patches were overlooked.  Applied now.  Thanks for reminding.

Shawn
