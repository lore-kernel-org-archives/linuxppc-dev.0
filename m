Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0141.outbound.protection.outlook.com [157.56.111.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5685D1A0094
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 06:09:39 +1000 (AEST)
Message-ID: <1429042165.22867.683.camel@freescale.com>
Subject: Re: [v2] powerpc/dts: Add some SoC specific "fsl,*-device-config"
 compatibles
From: Scott Wood <scottwood@freescale.com>
To: Igal.Liberman <igal.liberman@freescale.com>
Date: Tue, 14 Apr 2015 15:09:25 -0500
In-Reply-To: <1429007123-24649-1-git-send-email-igal.liberman@freescale.com>
References: <1429007123-24649-1-git-send-email-igal.liberman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-04-14 at 13:25 +0300, Igal.Liberman wrote:
> From: Igal Liberman <Igal.Liberman@freescale.com>
> 
> This patch adds "fsl,<chip>-device-config" compatibles to guts node.
> The added compatibles used in Freescale FMan clock initialization.
>  
> This patches is described by the following binding document update:
> 	https://patchwork.ozlabs.org/patch/461153/
> 
> v2: Updated commit message
> 
> Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
> ---
>  arch/powerpc/boot/dts/fsl/b4420si-post.dtsi |    3 ++-
>  arch/powerpc/boot/dts/fsl/b4860si-post.dtsi |    3 ++-
>  arch/powerpc/boot/dts/fsl/b4si-post.dtsi    |    3 ++-
>  arch/powerpc/boot/dts/fsl/p2041si-post.dtsi |    3 ++-
>  arch/powerpc/boot/dts/fsl/p3041si-post.dtsi |    3 ++-
>  arch/powerpc/boot/dts/fsl/p4080si-post.dtsi |    3 ++-
>  arch/powerpc/boot/dts/fsl/p5020si-post.dtsi |    3 ++-
>  7 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
> index 1ea8602..9b14f24 100644
> --- a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
> @@ -77,7 +77,8 @@
>  	};
>  
>  	guts: global-utilities@e0000 {
> -		compatible = "fsl,b4420-device-config", "fsl,qoriq-device-config-2.0";
> +		compatible = "fsl,b4420-device-config", "fsl,b4-device-config",
> +			      "fsl,qoriq-device-config-2.0";
>  	};

I thought you said you were going to drop this?  Please just use the
existing compatibles.

-Scott
