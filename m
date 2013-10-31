Return-Path: <sha@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D0D632C03BF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 18:29:31 +1100 (EST)
Date: Thu, 31 Oct 2013 08:29:07 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH v2 1/4] dma: imx-sdma: Add sdma firmware version 2 support
Message-ID: <20131031072907.GG24559@pengutronix.de>
References: <cover.1383197521.git.b42378@freescale.com>
 <cfe6edbff010aefc8a35df8a719b26bd238cb3cc.1383197521.git.b42378@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cfe6edbff010aefc8a35df8a719b26bd238cb3cc.1383197521.git.b42378@freescale.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org,
 swarren@wwwdotorg.org, timur@tabi.org, rob.herring@calxeda.com,
 linux-kernel@vger.kernel.org, broonie@kernel.org,
 ijc+devicetree@hellion.org.uk, dmaengine@vger.kernel.org, galak@codeaurora.org,
 shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 31, 2013 at 02:32:03PM +0800, Nicolin Chen wrote:
> On i.MX5/6 series, SDMA is using new version firmware to support SSI
> dual FIFO feature and HDMI Audio (i.MX6Q/DL only). Thus add it.
> 
> Signed-off-by: Nicolin Chen <b42378@freescale.com>
> ---
> diff --git a/include/linux/platform_data/dma-imx-sdma.h b/include/linux/platform_data/dma-imx-sdma.h
> index 3a39428..14ca582 100644
> --- a/include/linux/platform_data/dma-imx-sdma.h
> +++ b/include/linux/platform_data/dma-imx-sdma.h
> @@ -43,6 +43,9 @@ struct sdma_script_start_addrs {
>  	s32 dptc_dvfs_addr;
>  	s32 utra_addr;
>  	s32 ram_code_start_addr;

You could add a comment here, like: /* End of v1 array */

Otherwise:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

> +	s32 mcu_2_ssish_addr;
> +	s32 ssish_2_mcu_addr;
> +	s32 hdmi_dma_addr;
>  };
>  
>  /**
> -- 
> 1.8.4
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
