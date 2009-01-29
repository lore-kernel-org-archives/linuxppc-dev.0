Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 75A8BDDF94
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 06:06:17 +1100 (EST)
Message-Id: <0CE9A9BA-6168-4AE6-84DB-55D210723271@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Reynes Philippe <philippe.reynes@isismpp.fr>
In-Reply-To: <761F451C5F17F74DAEE4661DA5ABBC1616C448@factorix.ISISTHIBAUD.local>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] add gpio to mpc837X rdb
Date: Thu, 29 Jan 2009 12:38:03 -0600
References: <761F451C5F17F74DAEE4661DA5ABBC1616C448@factorix.ISISTHIBAUD.local>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 29, 2009, at 11:37 AM, Reynes Philippe wrote:

> Signed-off-by: Philippe Reynes <philippe.reynes@isismpp.fr>
> ---
> diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts
> b/arch/powerpc/boot/dts/mpc8377_rdb.dts
> index 165463f..45c9f03 100644
> --- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
> @@ -109,6 +109,24 @@
> 			reg = <0x200 0x100>;
> 		};
>
> +		gpio1: gpio-controller@c00 {
> +			#gpio-cells = <2>;
> +			compatible = "fsl,mpc8347-gpio",
> "fsl,mpc8349-gpio";
> +			reg = <0xc00 0x100>;
> +			interrupts = <74 0x8>;
> +			interrupt-parent = <&ipic>;
> +			gpio-controller;
> +		};
> +

seeing patch apply issues.. (line wrapping)

- k
