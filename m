Return-Path: <dgibson@bilbo.ozlabs.org>
Date: Wed, 1 Apr 2009 10:04:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 6/8] --- arch/powerpc/boot/dts/socrates.dts | 9
	+++++++-- 1 file changed, 7 insertions(+), 2 deletions(-)
Message-ID: <20090331230451.GA23304@yookeroo.seuss>
References: <20090331123727.853787299@denx.de>
	<20090331124036.057237866@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090331124036.057237866@denx.de>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 31, 2009 at 02:37:33PM +0200, Wolfgang Grandegger wrote:
> Index: linux-2.6/arch/powerpc/boot/dts/socrates.dts
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/boot/dts/socrates.dts	2009-03-31 13:24:38.078719288 +0200
> +++ linux-2.6/arch/powerpc/boot/dts/socrates.dts	2009-03-31 13:47:56.986720719 +0200
> @@ -52,6 +52,7 @@
>  	soc8544@e0000000 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> +		device_type = "soc";

You should not be adding device_type to a new board's dts.  You
*especially* shouldn't be doing that with no patch comment explaining
why.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
