Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1545EDE20D
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2009 01:44:01 +1100 (EST)
Message-Id: <408550B3-4109-4164-BE42-15D6B6A96871@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Reynes Philippe <philippe.reynes@isismpp.fr>
In-Reply-To: <761F451C5F17F74DAEE4661DA5ABBC1616C452@factorix.ISISTHIBAUD.local>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] add lm75 to mpc 837x rdb dts
Date: Fri, 30 Jan 2009 08:43:53 -0600
References: <761F451C5F17F74DAEE4661DA5ABBC1616C452@factorix.ISISTHIBAUD.local>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 30, 2009, at 8:34 AM, Reynes Philippe wrote:

> Signed-off-by: Philippe Reynes <philippe.reynes@isismpp.fr>
> ---
> diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts
> b/arch/powerpc/boot/dts/mpc8377_rdb.dts
> index e747486..38507ee 100644
> --- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
> @@ -137,6 +137,11 @@
> 			interrupt-parent = <&ipic>;
> 			dfsrr;
>
> +			dtt@48 {
> +				compatible = "national, lm75";

is there really a space between national, and lm75?

>
> +				reg = <0x48>;
> +			};
> +
> 			at24@50 {
> 				compatible = "at24,24c256";
> 				reg = <0x50>;
