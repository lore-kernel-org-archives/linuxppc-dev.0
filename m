Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0206.outbound.protection.outlook.com [207.46.163.206])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 33FE81A00D3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jul 2014 00:07:16 +1000 (EST)
Message-ID: <1404828418.21434.278.camel@snotra.buserror.net>
Subject: Re: [PATCH][v2]devicetree/binding/powerpc/fsl: Add binding for CPLD
From: Scott Wood <scottwood@freescale.com>
To: Priyanka Jain <Priyanka.Jain@freescale.com>
Date: Tue, 8 Jul 2014 09:06:58 -0500
In-Reply-To: <1404796006-3254-1-git-send-email-Priyanka.Jain@freescale.com>
References: <1404796006-3254-1-git-send-email-Priyanka.Jain@freescale.com>
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

On Tue, 2014-07-08 at 10:36 +0530, Priyanka Jain wrote:
> Some Freescale boards like T1040RDB have on board CPLD connected on
> the IFC bus. Add binding for this in board.txt file
> 
> Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
> ---
> Changes for v2: Incorporated Scott's comments

Isn't this v3?

>  .../devicetree/bindings/powerpc/fsl/board.txt      |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/board.txt b/Documentation/devicetree/bindings/powerpc/fsl/board.txt
> index 700dec4..67ef6a4 100644
> --- a/Documentation/devicetree/bindings/powerpc/fsl/board.txt
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/board.txt
> @@ -84,3 +84,19 @@ Example:
>  		compatible = "fsl,bsc9132qds-fpga", "fsl,fpga-qixis-i2c";
>  		reg = <0x66>;
>  	};
> +
> +* Freescale on-board CPLD
> +
> +Some Freescale boards like T1040RDB have on board CPLD connected.

s/have on board/have an on board/

> +
> +Required properties:
> +- compatible: Should be a board-specific string like "fsl,<board>-cpld"
> +  Example:
> +	"fsl,T1040RDB-cpld", "fsl,T1042RDB-cpld", "fsl,T1042RDB_PI-cpld"
> +- reg: should describe CPLD registers
> +
> +Example:
> +	cpld@3,0 {
> +		compatible = "fsl,T1040RDB-cpld";
> +		reg = <3 0 0x300>;
> +	};

Again, please keep the board name lowercase.

-Scott
