Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0104.outbound.protection.outlook.com [157.56.110.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 52D441A0C58
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 18:43:43 +1100 (AEDT)
Message-ID: <1421739810.4961.207.camel@freescale.com>
Subject: Re: [PATCH] powerpc/dts: Update platform PLL node
From: Scott Wood <scottwood@freescale.com>
To: Igal.Liberman <igal.liberman@freescale.com>
Date: Tue, 20 Jan 2015 01:43:30 -0600
In-Reply-To: <1421042407-13921-1-git-send-email-igal.liberman@freescale.com>
References: <1421042407-13921-1-git-send-email-igal.liberman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Emilian.Medve@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-01-12 at 08:00 +0200, Igal.Liberman wrote:
> From: Igal Liberman <Igal.Liberman@freescale.com>
> 
> Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
> Change-Id: I92d020651237041d3767aa35e9345439714f9831
> ---
>  arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Please explain this more.  Was it just wrong before?  Is this for a new
chip?  If the latter, what effect does this have on existing chips?

> diff --git a/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi
> index 48e0b6e..7e1f074 100644
> --- a/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi
> @@ -49,14 +49,16 @@ global-utilities@e1000 {
>  		reg = <0x800 0x4>;
>  		compatible = "fsl,qoriq-core-pll-2.0";
>  		clocks = <&sysclk>;
> -		clock-output-names = "pll0", "pll0-div2", "pll0-div4";
> +		clock-output-names = "pll0", "pll0-div2", "pll0-div3",
> +				      "pll0-div4";

You're changing the meaning of existing clock index 2.

-Scott
