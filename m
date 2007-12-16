Return-Path: <dgibson@ozlabs.org>
Date: Sun, 16 Dec 2007 17:30:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/3] mpc82xx: Embedded Planet EP8248E support
Message-ID: <20071216063020.GG21311@localhost.localdomain>
References: <20071211212247.GB3620@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071211212247.GB3620@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 11, 2007 at 03:22:47PM -0600, Scott Wood wrote:
[snip]
> +		bcsr@1,0 {
> +			#address-cells = <2>;
> +			#size-cells = <1>;
> +			reg = <1 0 10>;
> +			compatible = "fsl,ep8248e-bcsr";
> +			ranges;
> +
> +			mdio {
> +				device_type = "mdio";
> +				compatible = "fsl,ep8248e-mdio-bitbang";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <1 8 1>;
> +
> +				PHY0: ethernet-phy@0 {
> +					interrupt-parent = <&PIC>;
> +					reg = <0>;
> +					device_type = "ethernet-phy";
> +				};
> +
> +				PHY1: ethernet-phy@1 {
> +					interrupt-parent = <&PIC>;
> +					reg = <1>;
> +					device_type = "ethernet-phy";
> +				};
> +			};
> +		};

This mdio-under-bcsr arrangement is a bit strange.  Can you explain
what's going on here?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
