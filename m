Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id 0DD902C0351
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 23:42:44 +1100 (EST)
Message-ID: <526FAD41.2000805@tabi.org>
Date: Tue, 29 Oct 2013 07:42:41 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Nicolin Chen <b42378@freescale.com>, shawn.guo@linaro.org,
 broonie@kernel.org
Subject: Re: [PATCH 2/3] ASoC: fsl_ssi: Add dual fifo mode support
References: <cover.1383047327.git.b42378@freescale.com>
 <02f8867363ed3038a0a70703856e4b642fef4339.1383047327.git.b42378@freescale.com>
In-Reply-To: <02f8867363ed3038a0a70703856e4b642fef4339.1383047327.git.b42378@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org,
 s.hauer@pengutronix.de, swarren@wwwdotorg.org, linux-kernel@vger.kernel.org,
 rob.herring@calxeda.com, b32955@freescale.com, dmaengine@vger.kernel.org,
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

Nicolin Chen wrote:
> By enabling dual fifo mode, it would allow SSI enter a better performance
> to transimit/receive data without occasional hardware underrun/overrun.

Have you measured any real performance gain with this patch?  I 
considered adding dual-FIFO support when I originally wrote this driver, 
but it didn't appear to have any real benefit, but it used twice as many 
DMA channels.

I'm concerned that this is another patch that just enables a useless 
feature.
