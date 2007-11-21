Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D8FBDDDE02
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 04:32:56 +1100 (EST)
Date: Wed, 21 Nov 2007 11:33:08 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/3] [POWERPC] Add docs for Freescale DMA & DMA channel
	device tree nodes
Message-ID: <20071121173308.GB4413@loki.buserror.net>
References: <Pine.LNX.4.64.0711202310280.24220@blarg.am.freescale.net>
	<Pine.LNX.4.64.0711202314030.24220@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0711202314030.24220@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 20, 2007 at 11:14:40PM -0600, Kumar Gala wrote:
> +    - compatible        : compatible list, contains 2 entries, first is
> +			 "fsl,CHIP-dma", where CHIP is the processor
> +			 (mpc8540, mpc8540, etc.) and the second is
> +			 "fsl,eloplus-dma"

So if the DMA register set gets tweaked again, will we have eloplusplus? :-)
Maybe elo2 would be better.

Do we really need completely separate descriptions of the two, or
can we just describe the difference in the compatible section?

-Scott
