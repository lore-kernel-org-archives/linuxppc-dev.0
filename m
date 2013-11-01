Return-Path: <shawn.guo@linaro.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4927A2C00E0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2013 20:11:55 +1100 (EST)
Date: Fri, 1 Nov 2013 17:11:58 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Nicolin Chen <b42378@freescale.com>, Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 0/4] Add dual-fifo mode support of i.MX ssi
Message-ID: <20131101091156.GC10324@S2101-09.ap.freescale.net>
References: <cover.1383226444.git.b42378@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <cover.1383226444.git.b42378@freescale.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org,
 s.hauer@pengutronix.de, swarren@wwwdotorg.org, timur@tabi.org,
 rob.herring@calxeda.com, linux-kernel@vger.kernel.org, broonie@kernel.org,
 dmaengine@vger.kernel.org, ijc+devicetree@hellion.org.uk,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicolin,

The dmaengine maintainer Vinod Koul should be copied on the series.
(Just added).

On Thu, Oct 31, 2013 at 09:44:12PM +0800, Nicolin Chen wrote:
> Nicolin Chen (4):
>   dma: imx-sdma: Add sdma firmware version 2 support
>   dma: imx-sdma: Add new dma type for ssi dual fifo script
>   ASoC: fsl_ssi: Add dual fifo mode support
>   ARM: dts: imx: use dual-fifo sdma script for ssi

Vinod,

To keep git bisect, the series has to be merged through single tree.
Since Mark has ACK-ed patch #3, I think it's easier to merge the series
through your tree, so for patch #4:

Acked-by: Shawn Guo <shawn.guo@linaro.org>
