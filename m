Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 91BA3DDE0F
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 04:29:14 +1100 (EST)
Date: Wed, 21 Nov 2007 11:29:27 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/3] [POWERPC] Add docs for Freescale RapidIO device
	tree node
Message-ID: <20071121172927.GA4413@loki.buserror.net>
References: <Pine.LNX.4.64.0711202310280.24220@blarg.am.freescale.net>
	<Pine.LNX.4.64.0711202313350.24220@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0711202313350.24220@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 20, 2007 at 11:13:58PM -0600, Kumar Gala wrote:
>      Required properties:
>      - compatible        : compatible list, contains 2 entries, first is
> -			 "fsl,sata-CHIP", where CHIP is the processor
> +			 "fsl,CHIP-sata", where CHIP is the processor
>  			 (mpc8315, mpc8379, etc.) and the second is
> -			 "fsl,sata-pq2pro"
> +			 "fsl,pq2pro-sata"
>      - interrupts        : <interrupt mapping for SATA IRQ>
>      - interrupt-parent  : optional, if needed for interrupt mapping
>      - reg               : <registers mapping>
> @@ -2531,12 +2531,53 @@ platforms are moved over to use the flattened-device-tree model.
>     Example:
> 
>  	sata@19000 {
> -		compatible = "fsl,mpc8315-sata", "fsl,sata-pq2pro;
> +		compatible = "fsl,mpc8315-sata", "fsl,pq2pro-sata;

I think you meant to merge these changes with the previous patch...

-Scott
