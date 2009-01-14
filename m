Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 89885DDE9F
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 03:30:21 +1100 (EST)
Message-ID: <496E1317.9070804@freescale.com>
Date: Wed, 14 Jan 2009 10:30:15 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH] fsldma: print correct IRQ on mpc83xx
References: <1231944284-18296-1-git-send-email-jacmet@sunsite.dk>	<496E0E85.7060801@freescale.com>
	<87iqohc19b.fsf@macbook.be.48ers.dk>
In-Reply-To: <87iqohc19b.fsf@macbook.be.48ers.dk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, dan.j.williams@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Peter Korsgaard wrote:

> Why? Does it buy us anything to request_irq again for each channel?
> 
> Now we're at it, it seems like there's a check for != NO_IRQ missing
> in fsl_dma_chan_remove().

If the device tree doesn't specify an interrupts property in the device channel,
then I think that's an error.  All the device trees already do that.  So where
do you see this problem?


-- 
Timur Tabi
Linux kernel developer at Freescale
