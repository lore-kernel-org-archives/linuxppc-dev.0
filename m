Return-Path: <dgibson@ozlabs.org>
Date: Sat, 10 Feb 2007 11:47:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andy Fleming <afleming@freescale.com>
Subject: Re: Subject: [PATCH] Add support for the 8568 MDS board
Message-ID: <20070210004704.GC8276@localhost.localdomain>
References: <Pine.LNX.4.61.0702091727290.791@ld0175-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.61.0702091727290.791@ld0175-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 09, 2007 at 05:28:31PM -0600, Andy Fleming wrote:
[snip]
> +/ {
> +	model = "MPC8568EMDS";
> +	compatible = "MPC85xxMDS";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	linux,phandle = <100>;
> +
> +	cpus {
> +		#cpus = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		linux,phandle = <200>;

So, every Freescale device tree source I've seen so far has had these
hardcoded phandles all through it.  dtc has supported
reference-to-path to automatically generate the necessary phandles for
ages now.  Please can we use it...

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
