Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 031C0DDEC7
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 16:00:59 +1100 (EST)
In-Reply-To: <1173302064.23776.185.camel@ld0161-tx32>
References: <1173302064.23776.185.camel@ld0161-tx32>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0926D082-9EAC-4119-A3F9-F0EF130C606D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC 2/3] MPC8544 DTS file
Date: Wed, 7 Mar 2007 22:39:07 -0600
To: Jon Loeliger <jdl@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 7, 2007, at 3:14 PM, Jon Loeliger wrote:

> diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/ 
> boot/dts/mpc8544ds.dts
> new file mode 100644
> index 0000000..7eb7ccc
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/mpc8544ds.dts
> @@ -0,0 +1,352 @@
> +/*
> + * MPC8544 DS Device Tree Source
> + *
> + * Copyright 2007 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute  it and/or  
> modify it
> + * under  the terms of  the GNU General  Public License as  
> published by the
> + * Free Software Foundation;  either version 2 of the  License, or  
> (at your
> + * option) any later version.
> + */
> +
> +/ {
> +	model = "MPC8544DS";
> +	compatible = "mpc85xx";

Been doing the following on other 85xx:
         compatible = "MPC8540ADS", "MPC85xxADS";

Not sure if there will be other "DS" boards with 85xx?

[snip]

> +
> +	memory {
> +		device_type = "memory";
> +		reg = <00000000 20000000>;	// 512M at 0x0
> +	};

Does the u-boot fill this in?

> +
> +		mpic: pic@40000 {
> +			clock-frequency = <0>;
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			reg = <40000 40000>;
> +			built-in;
> +			compatible = "chrp,open-pic";
> +			device_type = "open-pic";
> +			big-endian;
> +
> +			interrupts = <
> +				10 2 11 2 12 2 13 2
> +				14 2 15 2 16 2 17 2
> +				18 2 19 2 1a 2 1b 2
> +				1c 2 1d 2 1e 2 1f 2
> +				20 2 21 2 22 2 23 2
> +				24 2 25 2 26 2 27 2
> +				28 2 29 2 2a 2 2b 2
> +				2c 2 2d 2 2e 2 2f 2
> +				30 2 31 2 32 2 33 2
> +				34 2 35 2 36 2 37 2
> +				38 2 39 2 2a 2 3b 2
> +				3c 2 3d 2 3e 2 3f 2
> +				48 1 49 2 4a 1
> +			>;
> +
> +

I think this is old and can be removed

> 			interrupt-parent = <&mpic>;
> +		};
> +	};
> +};

- k
