Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pa0-x22e.google.com (mail-pa0-x22e.google.com
 [IPv6:2607:f8b0:400e:c03::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4765F1A0289
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 20:31:56 +1100 (AEDT)
Received: by padhx2 with SMTP id hx2so17036222pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 01:31:54 -0800 (PST)
Date: Tue, 24 Nov 2015 01:31:48 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
 ijc+devicetree@hellion.org.uk, galak@codeaurora.org, timur@tabi.org,
 Xiubo.Lee@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V4 0/3] add spba clock for fsl audio IP
Message-ID: <20151124093147.GA50978@Asurada-CZ80>
References: <cover.1448356624.git.shengjiu.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1448356624.git.shengjiu.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 24, 2015 at 05:19:31PM +0800, Shengjiu Wang wrote:
> add spba clock for fsl audio IP
> 
> Changes in V3
> - add error check for spba clock
> 
> Shengjiu Wang (3):
>   ASoC: fsl_esai: spba clock is needed by esai device
>   ASoC: fsl_spdif: spba clk is needed by spdif device
>   ASoC: fsl_asrc: spba clock is needed by asrc device

For all three,

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> 
>  Documentation/devicetree/bindings/sound/fsl,asrc.txt  |  5 +++++
>  Documentation/devicetree/bindings/sound/fsl,esai.txt  |  5 +++++
>  Documentation/devicetree/bindings/sound/fsl,spdif.txt |  5 +++++
>  sound/soc/fsl/fsl_asrc.c                              | 14 ++++++++++++++
>  sound/soc/fsl/fsl_asrc.h                              |  2 ++
>  sound/soc/fsl/fsl_esai.c                              | 17 +++++++++++++++++
>  sound/soc/fsl/fsl_spdif.c                             | 19 +++++++++++++++++++
>  7 files changed, 67 insertions(+)
> 
> -- 
> 1.9.1
> 
