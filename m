Return-Path: <cbouatmailru@gmail.com>
Date: Thu, 5 May 2011 18:20:52 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 5/7] mmc: sdhci: consolidate sdhci-of-esdhc and
	sdhci-esdhc-imx
Message-ID: <20110505142051.GA17915@oksana.dev.rtsoft.ru>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
	<1304601778-13837-6-git-send-email-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1304601778-13837-6-git-send-email-shawn.guo@linaro.org>
Cc: sameo@linux.intel.com, Arnd Bergmann <arnd@arndb.de>, patches@linaro.org,
	devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org,
	Saeed Bishara <saeed@marvell.com>,
	Xiaobo Xie <X.Xie@freescale.com>, kernel@pengutronix.de,
	Mike Rapoport <mike@compulab.co.il>,
	Olof Johansson <olof@lixom.net>, Chris Ball <cjb@laptop.org>,
	linuxppc-dev@lists.ozlabs.org, Albert Herranz <albert_herranz@yahoo.es>,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 05, 2011 at 09:22:56PM +0800, Shawn Guo wrote:
> This patch is to consolidate SDHCI driver for Freescale eSDHC
> controller found on both MPCxxx and i.MX platforms.  It merges
> sdhci-of-esdhc.c into sdhci-esdhc.c, so that the same pair of
> .probe/.remove hook works with eSDHC for two platforms.
> 
> As the results, sdhci-of-esdhc.c and sdhci-esdhc.h are removed, and
> header esdhc.h containing the definition of esdhc_platform_data is
> put into the public folder.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

I'm not sure if that makes sense to merge these two.
I'd rather vote for renaming sdhci-of-esdhc to sdhci-esdhc-mpc. :-)

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
