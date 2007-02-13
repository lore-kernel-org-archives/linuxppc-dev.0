Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 60871DDEED
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 07:09:12 +1100 (EST)
In-Reply-To: <20070213061026.5837FDDDE9@ozlabs.org>
References: <20070213061026.5837FDDDE9@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e9a2d2be6fe9006c1e2e0b65099a1854@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
Date: Tue, 13 Feb 2007 21:08:52 +0100
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,440GP {

PowerPC,440GP@0

> +			clock-frequency = <5F5E100>; /* 100MHz FIXME: poke in zImage */
> +			timebase-frequency = <5F5E100>; /* 100MHz FIXME: wrong, poke in 
> zImage */

Can't you use decimal for these?

> +	UIC0: interrupt-controller { /* UIC0 */

> +		#address-cells = <0>;
> +		#size-cells = <0>;

#address-cells = 0 never makes sense.

> +	plb {
> +		device_type = "soc";
> +		compatible = "ibm,plb-440gp", "ibm,plb4";
> +		ranges;

You need a #address-cells, #size-cells here.


Segher
