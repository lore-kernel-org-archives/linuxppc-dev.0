Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0ACB5DE1E5
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2009 01:43:14 +1100 (EST)
Message-Id: <053AF4BE-EF48-4B6B-9E1F-91A72B767659@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Reynes Philippe <philippe.reynes@isismpp.fr>
In-Reply-To: <761F451C5F17F74DAEE4661DA5ABBC1616C44A@factorix.ISISTHIBAUD.local>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] add gpio to mpc837X rdb
Date: Fri, 30 Jan 2009 08:43:04 -0600
References: <761F451C5F17F74DAEE4661DA5ABBC1616C448@factorix.ISISTHIBAUD.local>
	<20090129192031.GA17060@oksana.dev.rtsoft.ru>
	<761F451C5F17F74DAEE4661DA5ABBC1616C44A@factorix.ISISTHIBAUD.local>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 30, 2009, at 3:57 AM, Reynes Philippe wrote:

> Signed-off-by: Philippe Reynes <philippe.reynes@isismpp.fr>
> ---
> diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts
> b/arch/powerpc/boot/dts/mpc8377_rdb.dts
> index 165463f..e747486 100644
> --- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
> @@ -109,6 +109,24 @@
> 			reg = <0x200 0x100>;
> 		};
>
> +		gpio1: gpio-controller@c00 {
> +			#gpio-cells = <2>;
> +			compatible = "fsl,mpc8377-gpio",
> "fsl,mpc8349-gpio";
> +			reg = <0xc00 0x100>;
> +			interrupts = <74 0x8>;
> +			interrupt-parent = <&ipic>;
> +			gpio-controller;
> +		};
> +
> +		gpio2: gpio-controller@d00 {
> +			#gpio-cells = <2>;
> +			compatible = "fsl,mpc8377-gpio",
> "fsl,mpc8349-gpio";
> +			reg = <0xd00 0x100>;
> +			interrupts = <75 0x8>;
> +			interrupt-parent = <&ipic>;
> +			gpio-controller;
> +		};

still seeing line wrapping issues.

- k
