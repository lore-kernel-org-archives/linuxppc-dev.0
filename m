Return-Path: <galak@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.11.231])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 198D92C00E7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 04:21:55 +1100 (EST)
Subject: Re: [PATCH 1/3] dma: imx-sdma: Add ssi dual fifo script support
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@codeaurora.org>
In-Reply-To: <9ed025d4e98f716ba80b27acaaa98f43ad3bd75a.1383047327.git.b42378@freescale.com>
Date: Tue, 29 Oct 2013 12:21:52 -0500
Message-Id: <4648FA57-F1B4-4341-A536-BAA43364165D@codeaurora.org>
References: <cover.1383047327.git.b42378@freescale.com>
 <9ed025d4e98f716ba80b27acaaa98f43ad3bd75a.1383047327.git.b42378@freescale.com>
To: Nicolin Chen <b42378@freescale.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org,
 s.hauer@pengutronix.de, swarren@wwwdotorg.org, timur@tabi.org,
 rob.herring@calxeda.com, linux-kernel@vger.kernel.org, b32955@freescale.com,
 broonie@kernel.org, ijc+devicetree@hellion.org.uk, dmaengine@vger.kernel.org,
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


On Oct 29, 2013, at 7:33 AM, Nicolin Chen wrote:

> There's a script for SSI missing in current sdma script list. Thus add =
it.
> This script would allow SSI use its dual fifo mode to =
transimit/receive
> data without occasional hardware underrun/overrun.
>=20
> This patch also fixed a counting error for total number of scripts.
>=20
> Signed-off-by: Nicolin Chen <b42378@freescale.com>
> ---
> Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt | 1 +
> drivers/dma/imx-sdma.c                                 | 6 +++++-
> include/linux/platform_data/dma-imx-sdma.h             | 2 ++
> include/linux/platform_data/dma-imx.h                  | 1 +
> 4 files changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt =
b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> index 4fa814d..3b933c5 100644
> --- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> +++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> @@ -42,6 +42,7 @@ The full ID of peripheral types can be found below.
> 	19	IPU Memory
> 	20	ASRC
> 	21	ESAI
> +	22	SSI Dual FIFO
>=20
> The third cell specifies the transfer priority as below.

For the DT-Binding portion:

Acked-by: Kumar Gala <galak@codeaurora.org>

- k

--=20
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, =
hosted by The Linux Foundation
