Return-Path: <dgibson@ozlabs.org>
Date: Mon, 8 Oct 2007 11:53:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [PATCH 07/15] [POWERPC] Promess Motion-PRO DTS
Message-ID: <20071008015316.GB12499@localhost.localdomain>
References: <47075FA7.3030108@semihalf.com> <4708C22D.5060805@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4708C22D.5060805@semihalf.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Oct 07, 2007 at 01:25:33PM +0200, Marian Balakowicz wrote:
> 
> Add device tree source file for Motion-PRO board.
> 
> Signed-off-by: Marian Balakowicz <m8@semihalf.com>
> ---
> 
>  motionpro.dts |  334 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 334 insertions(+)
> 
> diff --git a/arch/powerpc/boot/dts/motionpro.dts b/arch/powerpc/boot/dts/motionpro.dts
> new file mode 100644
> index 0000000..4b197c8
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/motionpro.dts
> @@ -0,0 +1,334 @@
> +/*
> + * Motion-PRO board Device Tree Source, based on Lite5200B DTS.
> + *
> + * Copyright (C) 2007 Semihalf
> + * Modified for CM5200 by Marian Balakowicz <m8@semihalf.com>
> + *
> + * Copyright 2006-2007 Secret Lab Technologies Ltd.
> + * Grant Likely <grant.likely@secretlab.ca>
> + *
> + * Copyright (C) 2007 DENX Software Engineering
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +/*
> + * WARNING: Do not depend on this tree layout remaining static just yet.
> + * The MPC5200 device tree conventions are still in flux
> + * Keep an eye on the linuxppc-dev mailing list for more details
> + */
> +
> +/ {
[snip]
> +	kollmorgen {
> +		device_type = "kollmorgen";
> +		compatible = "kollmorgen";
> +		reg = <50000000 ffff>;
> +		interrupts = <1 1 0>;
> +		interrupt-parent = <&mpc5200_pic>;
> +	};
> +	cpld {
> +		device_type = "cpld";
> +		compatible = "cpld";
> +		reg = <50010000 ffff>;
> +	};
> +	anybus {
> +		device_type = "anybus";
> +		compatible = "anybus";
> +		reg = <50020000 ffff>;
> +	};
> +	pro_module_general {
> +		device_type = "pro_module_general";
> +		compatible = "pro_module_general";
> +		reg = <50020000 3>;
> +	};
> +	pro_module_dio {
> +		device_type = "pro_module_dio";
> +		compatible = "pro_module_dio";
> +		reg = <50020800 2>;
> +	};

Surely there must be some sort of bus controller above these devices..?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
