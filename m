Return-Path: <dgibson@ozlabs.org>
Date: Tue, 8 May 2007 10:19:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 02/13] Document devtree binding for power management
	controllers.
Message-ID: <20070508001909.GE7449@localhost.localdomain>
References: <20070507182907.GA26897@ld0162-tx32.am.freescale.net>
	<20070507182943.GA26920@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070507182943.GA26920@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yergh.  It would be nice to have a wiki or something for all this
binding information, instead of doing as patches to a monster text
document.

On Mon, May 07, 2007 at 01:29:43PM -0500, Scott Wood wrote:
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  Documentation/powerpc/booting-without-of.txt |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
> index aaea829..fc54511 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -1725,6 +1725,19 @@ platforms are moved over to use the flattened-device-tree model.
>   		partition-names = "fs\0firmware";
>   	};
>  
> +   k) Power Management Controllers
> +
> +   Required Properties:
> +
> +   - compatible : mpc83xx chips should use "fsl,mpc83xx-pmc".  831x chips
> +     with additional PMC functionality also list "fsl,mpc831x-pmc".
> +   - reg : For fsl,mpc83xx-pmc devices, resource 0 is the PMC reg block,
> +     and resource 1 is the Clock Configuration reg block.
> +
> +   Optional Properties:
> +
> +   - interrupts : On fsl,mpc83xx-pmc, this is the PMC interrupt.
> +
>     More devices will be defined as this spec matures.
>  
>  VII - Specifying interrupt information for devices

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
