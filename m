Return-Path: <shawn.guo@linaro.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6F1D52C008C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 00:02:51 +1000 (EST)
Date: Thu, 25 Jul 2013 22:01:52 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH] ASoC: fsl: Set sdma peripheral type directly
Message-ID: <20130725140150.GB19368@S2101-09.ap.freescale.net>
References: <1374745301-29508-1-git-send-email-b42378@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1374745301-29508-1-git-send-email-b42378@freescale.com>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org,
 broonie@kernel.org, linuxppc-dev@lists.ozlabs.org, timur@tabi.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 25, 2013 at 05:41:41PM +0800, Nicolin Chen wrote:
> Let CPU DAI drivers set SDMA periperal type directly to support more
> dma types(SPDIF, ESAI) other than only two for SSI.
> This will easily allow some non-SSI drivers to use the imx-pcm-dma
> as well.
> 
> Signed-off-by: Nicolin Chen <b42378@freescale.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
