Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 08FB61007DB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  6 May 2011 18:40:27 +1000 (EST)
Date: Fri, 6 May 2011 10:39:59 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 7/7] ARM: mxc: remove esdhc.h and use the public one
Message-ID: <20110506083959.GS11574@pengutronix.de>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
	<1304601778-13837-8-git-send-email-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1304601778-13837-8-git-send-email-shawn.guo@linaro.org>
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>, sameo@linux.intel.com,
	Arnd Bergmann <arnd@arndb.de>, patches@linaro.org,
	devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org,
	Saeed Bishara <saeed@marvell.com>,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
	Mike Rapoport <mike@compulab.co.il>,
	Olof Johansson <olof@lixom.net>, Chris Ball <cjb@laptop.org>,
	linuxppc-dev@lists.ozlabs.org, Albert Herranz <albert_herranz@yahoo.es>,
	Xiaobo Xie <X.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Shawn,

On Thu, May 05, 2011 at 09:22:58PM +0800, Shawn Guo wrote:
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  .../plat-mxc/devices/platform-sdhci-esdhc-imx.c    |    1 -
>  arch/arm/plat-mxc/include/mach/devices-common.h    |    2 +-
what about removing arch/arm/plat-mxc/include/mach/esdhc.h in this
patch as advertised in the subject?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
