Return-Path: <swarren@wwwdotorg.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org
 [IPv6:2001:470:1f0f:bd7::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 335182C0120
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2013 02:17:11 +1000 (EST)
Message-ID: <52139680.1010800@wwwdotorg.org>
Date: Tue, 20 Aug 2013 10:17:04 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH v9 2/2] ASoC: fsl: Add S/PDIF machine driver
References: <cover.1376972170.git.b42378@freescale.com>
 <ede222d17047e863da34a78069ceead2668bd5d2.1376972170.git.b42378@freescale.com>
In-Reply-To: <ede222d17047e863da34a78069ceead2668bd5d2.1376972170.git.b42378@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de, festevam@gmail.com,
 s.hauer@pengutronix.de, timur@tabi.org, rob.herring@calxeda.com,
 tomasz.figa@gmail.com, broonie@kernel.org, p.zabel@pengutronix.de,
 R65777@freescale.com, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/19/2013 10:32 PM, Nicolin Chen wrote:
> This patch implements a device-tree-only machine driver for Freescale
> i.MX series Soc. It works with spdif_transmitter/spdif_receiver and
> fsl_spdif.c drivers.
> 
> Signed-off-by: Nicolin Chen <b42378@freescale.com>
> ---
>  .../devicetree/bindings/sound/imx-audio-spdif.txt  |   29 +++++

What changed between v8 and v9?

> diff --git a/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt b/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt

> +Optional properties:
> +
> +  - spdif-transmitter : The phandle of the spdif-transmitter dummy codec
> +
> +  - spdif-receiver : The phandle of the spdif-receiver dummy codec
> +
> +* Note: At least one of these two properties should be set in the DT binding.

I still don't think "dummy CODEC" is an appropriate thing to have in DT.
