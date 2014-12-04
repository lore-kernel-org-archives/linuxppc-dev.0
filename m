Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F9371A0010
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 15:51:25 +1100 (AEDT)
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0111.outbound.protection.outlook.com [65.55.169.111])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A88061400E2
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2014 15:51:24 +1100 (AEDT)
Message-ID: <1417668674.15957.243.camel@freescale.com>
Subject: Re: [PATCH v4 1/6] dt/bindings: bman: Add phandle to the portals
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
Date: Wed, 3 Dec 2014 22:51:14 -0600
In-Reply-To: <1417600964-24647-2-git-send-email-Emilian.Medve@Freescale.com>
References: <1417600964-24647-1-git-send-email-Emilian.Medve@Freescale.com>
 <1417600964-24647-2-git-send-email-Emilian.Medve@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-12-03 at 04:02 -0600, Emil Medve wrote:
> This supports SoC(s) with multiple BMan instances
> 
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> ---
>  Documentation/devicetree/bindings/soc/fsl/bman.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/fsl/bman.txt b/Documentation/devicetree/bindings/soc/fsl/bman.txt
> index 9f80bf8..4fc4a6e 100644
> --- a/Documentation/devicetree/bindings/soc/fsl/bman.txt
> +++ b/Documentation/devicetree/bindings/soc/fsl/bman.txt
> @@ -36,6 +36,11 @@ are located at offsets 0xbf8 and 0xbfc
>  	Value type:	<prop-encoded-array>
>  	Definition:	Standard property. The error interrupt
>  
> +- fsl,bman-portals
> +	Usage:		Required
> +	Value type:	<phandle>
> +	Definition:	Phandle to this BMan's instance portals

s/BMan's instance/BMan instance's/

Likewise for QMan

-Scott
