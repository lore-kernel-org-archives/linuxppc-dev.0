Return-Path: <r65073@freescale.com>
Date: Fri, 27 May 2011 17:07:39 +0800
From: Shawn Guo <shawn.guo@freescale.com>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v3 0/4] Consolidate sdhci pltfm & OF drivers and get them
	self registered
Message-ID: <20110527090738.GC30146@S2100-06.ap.freescale.net>
References: <1306321314-2493-1-git-send-email-shawn.guo@linaro.org>
	<20110527072647.GE31953@ponder.secretlab.ca>
	<20110527080650.GA11592@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20110527080650.GA11592@pengutronix.de>
Cc: Chris Ball <cjb@laptop.org>, sameo@linux.intel.com,
	Arnd Bergmann <arnd@arndb.de>, patches@linaro.org,
	devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org,
	Saeed Bishara <saeed@marvell.com>,
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

On Fri, May 27, 2011 at 10:06:50AM +0200, Wolfram Sang wrote:
> 
> > Any chance we can get this series into $NEXT_KERNEL?
> 
> From the looks, I think it still has problems being a module. Will try
> to test it today.
> 
Sorry.  I forgot testing module build.  I'm fixing it.

-- 
Regards,
Shawn
