Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E5AD4DE51F
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 08:16:34 +1100 (EST)
Message-ID: <47A38C49.7020606@freescale.com>
Date: Fri, 01 Feb 2008 15:16:57 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] [POWERPC] fsl_soc: add support for "fsl, immr" compatible
	matching
References: <20080201150117.GA26545@localhost.localdomain>
In-Reply-To: <20080201150117.GA26545@localhost.localdomain>
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

Anton Vorontsov wrote:
> -	soc8540@e0000000 {
> +	soc@e0000000 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		#interrupt-cells = <2>;
> -		device_type = "soc";
> +		compatible = "fsl,mpc8540-immr", "fsl,immr", "simple-bus";
>  		ranges = <00000000 e0000000 00100000>
>  		reg = <e0000000 00003000>;
>  		bus-frequency = <0>;

It's called "CCSR" rather than "IMMR" on 85xx.

-Scott
