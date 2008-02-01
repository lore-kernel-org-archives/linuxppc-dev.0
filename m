Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BF34DDDEA3
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 08:01:03 +1100 (EST)
Message-ID: <47A38888.1010901@freescale.com>
Date: Fri, 01 Feb 2008 15:00:56 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: "Bryan O'Donoghue" <bodonoghue@codehermit.ie>
Subject: Re: PATCH[1/1] 8xx: Add clock-frequency to Adder875 and mpc885ads
	board ports
References: <1201736088.3466.3.camel@neuromancer.mindspace>
In-Reply-To: <1201736088.3466.3.camel@neuromancer.mindspace>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Bryan O'Donoghue wrote:
> Redo the addition of the clock-frequency parameter to the Adder875 .dts
> so that the values are decimal rather then hex.
> 
> 
> Signed-off-by: Bryan O'Donoghue <bodonoghue@codehermit.ie>
> ---
> 
> diff --git a/arch/powerpc/boot/dts/adder875-redboot.dts
> b/arch/powerpc/boot/dts/adder875-redboot.dts
> index 7c25d96..c508f3c 100644
> --- a/arch/powerpc/boot/dts/adder875-redboot.dts
> +++ b/arch/powerpc/boot/dts/adder875-redboot.dts
> @@ -149,6 +149,7 @@
>                                 compatible = "fsl,mpc875-brg",
>                                              "fsl,cpm1-brg",
>                                              "fsl,cpm-brg";
> +                               clock-frequency = <50000000>;
>                                 reg = <0x9f0 0x10>;
>                         };

This patch is whitespace-mangled (all tabs are spaces, even in quoted 
sections).

-Scott
