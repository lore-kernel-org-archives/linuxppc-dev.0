Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 75809B7089
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jul 2009 20:32:08 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 62FCADDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2009 20:32:08 +1000 (EST)
Date: Wed, 29 Jul 2009 20:32:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Heiko Schocher <hs@denx.de>
Subject: Re: 82xx, mgcoge: updates for 2.6.32
Message-ID: <20090729103203.GA6369@yookeroo.seuss>
References: <4A70091E.7000002@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A70091E.7000002@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 29, 2009 at 10:32:30AM +0200, Heiko Schocher wrote:

[snip]
> +			mdio@10d40 {
> +				device_type = "mdio";

Drop this device_type.

> +				compatible = "fsl,cpm2-mdio-bitbang";
> +				reg = <0x10d00 0x14>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				fsl,mdio-pin = <12>;
> +				fsl,mdc-pin = <13>;
> +
> +				phy0: ethernet-phy@0 {
> +					reg = <0x0>;
> +					device_type = "ethernet-phy";

And this one, too.

> +				};
> +
> +				phy1: ethernet-phy@1 {
> +					reg = <0x1>;
> +					device_type = "ethernet-phy";
> +				};
> +			};

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
