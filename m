Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id C73C3DDDEE
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 09:27:31 +1100 (EST)
Date: Wed, 5 Dec 2007 15:28:16 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] Add aliases node to 8641hpcn DTS file.
Message-ID: <20071205222816.GA3725@mag.az.mvista.com>
References: <1196875970.8544.12.camel@ld0161-tx32>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1196875970.8544.12.camel@ld0161-tx32>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 05, 2007 at 11:32:50AM -0600, Jon Loeliger wrote:

> diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> index abb26dc..b039f21 100644
> --- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> +++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> @@ -16,6 +16,17 @@
>  	#address-cells = <1>;
>  	#size-cells = <1>;
>  
> +	aliases {
> +		ethernet0 = &enet0;
> +		ethernet1 = &enet1;
> +		ethernet2 = &enet2;
> +		ethernet3 = &enet3;
> +		serial0 = &serial0;
> +		serial1 = &serial1;
> +		pci0 = &pci0;
> +		pci1 = &pci1;
> +	};
> +
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> @@ -107,7 +118,7 @@
>  			};
>  		};
>  
> -		ethernet@24000 {
> +		enet0: ethernet@24000 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			device_type = "network";

This is probably a dumb question but I'll ask it anyway.

What's the point of 'aliases' when you already have labels?
E.g., why not just use enet0 instead of making an ethernet0 alias?

Mark
