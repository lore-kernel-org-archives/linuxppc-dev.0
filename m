Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 09C1CDE081
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 02:57:38 +1100 (EST)
Date: Wed, 26 Mar 2008 10:57:41 -0500
From: Scott Wood <scottwood@freescale.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCHv2 2/3] ep8248e: Reference SMC parameter RAM base in the
	device tree.
Message-ID: <20080326155741.GA3460@loki.buserror.net>
References: <200803261217.46671.laurentp@cse-semaphore.com>
	<200803261220.43039.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200803261220.43039.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 26, 2008 at 12:20:42PM +0100, Laurent Pinchart wrote:
> diff --git a/arch/powerpc/boot/dts/ep8248e.dts b/arch/powerpc/boot/dts/ep8248e.dts
> index 5d2fb76..756758f 100644
> --- a/arch/powerpc/boot/dts/ep8248e.dts
> +++ b/arch/powerpc/boot/dts/ep8248e.dts
> @@ -121,8 +121,7 @@
>  
>  				data@0 {
>  					compatible = "fsl,cpm-muram-data";
> -					reg = <0 0x1100 0x1140
> -					       0xec0 0x9800 0x800>;
> +					reg = <0 0x2000 0x9800 0x800>;
>  				};

Can we leave this as reserved, so that udbg still works?

-Scott
