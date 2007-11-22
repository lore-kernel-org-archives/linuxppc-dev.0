Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 12B40DDE46
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 11:48:28 +1100 (EST)
Message-ID: <4744D226.9060807@freescale.com>
Date: Wed, 21 Nov 2007 18:49:42 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/3] [POWERPC] Add docs for Freescale DMA & DMA channel
	device tree nodes
References: <Pine.LNX.4.64.0711202310280.24220@blarg.am.freescale.net>
	<Pine.LNX.4.64.0711202314030.24220@blarg.am.freescale.net>
	<474447EF.8080405@freescale.com>
	<E9CED991-4E10-44AE-A446-B6CB151FB9EE@kernel.crashing.org>
	<20071121173540.GC4413@loki.buserror.net>
In-Reply-To: <20071121173540.GC4413@loki.buserror.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:

> I don't see any justification for having such a property in the parent node,
> though.

The SSI needs to know which DMA controller is #0 and which one is #1.

I literally program the SSI and the GUTS registers with the DMA controller and 
channels numbers.  I need to know which one is which!

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
