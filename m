Return-Path: <R65073@freescale.com>
Date: Fri, 20 May 2011 00:09:02 +0800
From: Shawn Guo <shawn.guo@freescale.com>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v2 0/7] Consolidate sdhci pltfm & OF drivers and get them
	self registered
Message-ID: <20110519160901.GC26816@S2100-06.ap.freescale.net>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
	<20110519094046.GA2219@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20110519094046.GA2219@pengutronix.de>
Cc: Chris Ball <cjb@laptop.org>, Anton Vorontsov <avorontsov@ru.mvista.com>,
	sameo@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
	patches@linaro.org, devicetree-discuss@lists.ozlabs.org,
	linux-mmc@vger.kernel.org, Saeed Bishara <saeed@marvell.com>,
	Xiaobo Xie <X.Xie@freescale.com>, kernel@pengutronix.de,
	Mike Rapoport <mike@compulab.co.il>, Olof Johansson <olof@lixom.net>,
	Shawn Guo <shawn.guo@linaro.org>, linuxppc-dev@lists.ozlabs.org,
	Albert Herranz <albert_herranz@yahoo.es>,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wolfram,

On Thu, May 19, 2011 at 11:40:46AM +0200, Wolfram Sang wrote:
> Hi Shawn,
> 
> > Changes since v1:
> >  * Rebase on cjb's mmc-next tree
> 
> Is it maybe possible that you get access to
> http://opensource.freescale.com/git or another machine? A branch to pull
> from would be more convenient, because the series does not apply to
> mmc-next anymore, so an extra step to go "back in time" is needed.
> 
> (minor) When applying I got:
> 
> Applying: mmc: sdhci: make sdhci-pltfm device drivers self registered
> /home/wsa/Kernel/linux-2.6/.git/rebase-apply/patch:384: trailing whitespace.
> /home/wsa/Kernel/linux-2.6/.git/rebase-apply/patch:817: space before tab in indent.
>  	struct tegra_sdhci_platform_data *plat;
> /home/wsa/Kernel/linux-2.6/.git/rebase-apply/patch:867: trailing whitespace.
> 
> Applying: sdhci: rename sdhci-esdhc-imx.c to sdhci-esdhc.c
> /home/wsa/Kernel/linux-2.6/.git/rebase-apply/patch:780: trailing whitespace.
> 
> See later comments for further issues.
> 
Should I go for v3 right now to address the patch applying problems
and that ESDHC_IMX build issue, or hold for a while to see if you
have more comments on v2?

And what is your position on patch #5 which merges esdhc imx and mpc
support into one?  As Anton has voted a NO there, I would probably
drop the patch if there is another person has strong opinion to get
imx and mpc stay separated.

-- 
Regards,
Shawn
