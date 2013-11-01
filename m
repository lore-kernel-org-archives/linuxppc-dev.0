Return-Path: <B42378@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0185.outbound.messaging.microsoft.com [213.199.154.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7CE032C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2013 20:45:54 +1100 (EST)
Date: Fri, 1 Nov 2013 17:33:27 +0800
From: Nicolin Chen <b42378@freescale.com>
To: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v4 0/4] Add dual-fifo mode support of i.MX ssi
Message-ID: <20131101093326.GE28401@MrMyself>
References: <cover.1383226444.git.b42378@freescale.com>
 <20131101091156.GC10324@S2101-09.ap.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20131101091156.GC10324@S2101-09.ap.freescale.net>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org,
 Vinod Koul <vinod.koul@intel.com>, s.hauer@pengutronix.de,
 swarren@wwwdotorg.org, timur@tabi.org, rob.herring@calxeda.com,
 linux-kernel@vger.kernel.org, broonie@kernel.org, dmaengine@vger.kernel.org,
 ijc+devicetree@hellion.org.uk, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 01, 2013 at 05:11:58PM +0800, Shawn Guo wrote:
> Nicolin,
> 
> The dmaengine maintainer Vinod Koul should be copied on the series.
> (Just added).
>

Ah, I was careless last night when I sent these patches. My VPN connection
was pretty laggy :( Please forgive me, Vinod.

Thank Shawn for adding for me. Much obliged.

> On Thu, Oct 31, 2013 at 09:44:12PM +0800, Nicolin Chen wrote:
> > Nicolin Chen (4):
> >   dma: imx-sdma: Add sdma firmware version 2 support
> >   dma: imx-sdma: Add new dma type for ssi dual fifo script
> >   ASoC: fsl_ssi: Add dual fifo mode support
> >   ARM: dts: imx: use dual-fifo sdma script for ssi
> 
> Vinod,
> 
> To keep git bisect, the series has to be merged through single tree.
> Since Mark has ACK-ed patch #3, I think it's easier to merge the series
> through your tree, so for patch #4:
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
