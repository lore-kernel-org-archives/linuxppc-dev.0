Return-Path: <varkabhadram@gmail.com>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 13E3F1A0972
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jul 2014 21:35:39 +1000 (EST)
Received: by mail-pa0-f47.google.com with SMTP id kx10so5949542pab.34
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jul 2014 04:35:37 -0700 (PDT)
Message-ID: <53D240B3.8060203@gmail.com>
Date: Fri, 25 Jul 2014 17:04:11 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
To: Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org
Subject: Re: [PATCH v5 2/2] ASoC: fsl_asrc: Add ASRC ASoC CPU DAI and platform
 drivers
References: <cover.1406276436.git.nicoleotsuka@gmail.com>
 <2288e61e600e28448905e32dd4f74a954110248f.1406276436.git.nicoleotsuka@gmail.com>
In-Reply-To: <2288e61e600e28448905e32dd4f74a954110248f.1406276436.git.nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, b42378@freescale.com, timur@tabi.org,
 pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, tiwai@suse.de,
 linux-kernel@vger.kernel.org, rdunlap@infradead.org, b02247@freescale.com,
 lgirdwood@gmail.com, perex@perex.cz, robh+dt@kernel.org, galak@codeaurora.org,
 grant.likely@linaro.org, tklauser@distanz.ch, shawn.guo@linaro.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/25/2014 02:16 PM, Nicolin Chen wrote:
> The Asynchronous Sample Rate Converter (ASRC) converts the sampling rate of a
> signal associated with an input clock into a signal associated with a different
> output clock. The driver currently works as a Front End of DPCM with other Back
> Ends DAI links such as ESAI<->CS42888 and SSI<->WM8962 and SAI. It converts the
> original sample rate to a common rate supported by Back Ends for playback while
> converts the common rate of Back Ends to a desired rate for capture. It has 3
> pairs to support three different substreams within totally 10 channels.
>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>   .../devicetree/bindings/sound/fsl,asrc.txt         |  60 ++
>   sound/soc/fsl/Kconfig                              |   9 +
>   sound/soc/fsl/Makefile                             |   2 +
>   sound/soc/fsl/fsl_asrc.c                           | 992 +++++++++++++++++++++
>   sound/soc/fsl/fsl_asrc.h                           | 461 ++++++++++
>   sound/soc/fsl/fsl_asrc_dma.c                       | 386 ++++++++
>   6 files changed, 1910 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/sound/fsl,asrc.txt
>   create mode 100644 sound/soc/fsl/fsl_asrc.c
>   create mode 100644 sound/soc/fsl/fsl_asrc.h
>   create mode 100644 sound/soc/fsl/fsl_asrc_dma.c
>
>
check patch warnings on this patch...

-- 
Regards,
Varka Bhadram.
