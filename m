Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DFD64DE61B
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 03:59:19 +1100 (EST)
Message-ID: <47EA80ED.1030202@freescale.com>
Date: Wed, 26 Mar 2008 11:59:25 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCHv2 2/3] ep8248e: Reference SMC parameter RAM base in the
	device tree.
References: <200803261217.46671.laurentp@cse-semaphore.com>
	<200803261220.43039.laurentp@cse-semaphore.com>
In-Reply-To: <200803261220.43039.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Laurent Pinchart wrote:
> @@ -138,7 +137,7 @@
>  				device_type = "serial";
>  				compatible = "fsl,mpc8248-smc-uart",
>  				             "fsl,cpm2-smc-uart";
> -				reg = <0x11a80 0x20 0x1100 0x40>;
> +				reg = <0x11a80 0x20 0x87fc 2>;
>  				interrupts = <4 8>;
>  				interrupt-parent = <&PIC>;
>  				fsl,cpm-brg = <7>;

This breaks the bootwrapper console.

-Scott
