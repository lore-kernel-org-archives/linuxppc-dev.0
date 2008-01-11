Return-Path: <dgibson@ozlabs.org>
Date: Fri, 11 Jan 2008 11:20:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH 2/5] Warp Base Platform - dts
Message-ID: <20080111002037.GB23402@localhost.localdomain>
References: <47852C41.8000506@pikatech.com> <47852CB3.3000208@pikatech.com>
	<20080110024753.GC17816@localhost.localdomain>
	<4786B147.5070206@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4786B147.5070206@pikatech.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 10, 2008 at 06:59:03PM -0500, Sean MacLennan wrote:
> New version with recommended changes. Device types removed. FPGA
> moved to correct bus.

[snip]
> +				fpga@2,0 {
> +					compatible = "pika,fpga";
> +			   		reg = <0 80000000 2200>;

Your reg property doesn't match your node name here...

> +					interrupts = <18 8>;
> +					interrupt-parent = <&UIC0>;
> +				};

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
