Return-Path: <cbouatmailru@gmail.com>
Date: Thu, 5 May 2011 18:23:52 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 2/7] mmc: sdhci: eliminate sdhci_of_host and
	sdhci_of_data
Message-ID: <20110505142352.GB17915@oksana.dev.rtsoft.ru>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
	<1304601778-13837-3-git-send-email-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1304601778-13837-3-git-send-email-shawn.guo@linaro.org>
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

On Thu, May 05, 2011 at 09:22:53PM +0800, Shawn Guo wrote:
> The patch migrates the use of sdhci_of_host and sdhci_of_data to
> sdhci_pltfm_host and sdhci_pltfm_data, so that the former pair can
> be eliminated.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Reviewed-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks!

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
