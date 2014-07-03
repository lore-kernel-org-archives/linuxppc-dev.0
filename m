Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0211.outbound.protection.outlook.com [207.46.163.211])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 87F591A0004
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 04:08:13 +1000 (EST)
Message-ID: <1404410878.21434.70.camel@snotra.buserror.net>
Subject: Re: [PATCH] devicetree/binding/powerpc/fsl: Add binding for CPLD
From: Scott Wood <scottwood@freescale.com>
To: Priyanka Jain <Priyanka.Jain@freescale.com>
Date: Thu, 3 Jul 2014 13:07:58 -0500
In-Reply-To: <1404382185-2967-1-git-send-email-Priyanka.Jain@freescale.com>
References: <1404382185-2967-1-git-send-email-Priyanka.Jain@freescale.com>
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

On Thu, 2014-07-03 at 15:39 +0530, Priyanka Jain wrote:
> Some Freescale boards like T1040RDB have on board CPLD connected on
> the IFC bus. Add binding for this in board.txt file
> 
> Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
> ---
>  .../devicetree/bindings/powerpc/fsl/board.txt      |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/board.txt b/Documentation/devicetree/bindings/powerpc/fsl/board.txt
> index 700dec4..f35f295 100644
> --- a/Documentation/devicetree/bindings/powerpc/fsl/board.txt
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/board.txt
> @@ -84,3 +84,22 @@ Example:
>  		compatible = "fsl,bsc9132qds-fpga", "fsl,fpga-qixis-i2c";
>  		reg = <0x66>;
>  	};
> +
> +* Freescale on-board CPLD
> +
> +Some Freescale boards like T1040RDB have on board CPLD connected on
> +the IFC bus.
> +
> +Required properties:
> +- compatible: Should be a board-specific string like "fsl,<board>-cpld"
> +  Example:
> +	"fsl,T1040RDB-cpld", "fsl,T1042RDB-cpld", "fsl,T1042RDB_PI-cpld"
> +- reg: Should contain the chip select, address offset and length of the CPLD
> +
> +Example:
> +	cpld@3,0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "fsl,T1040RDB-cpld";
> +		reg = <3 0 0x300>;
> +	};

Please keep the board name in lowercase like the rest.

-Scott
