Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7D074DDFE8
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 05:26:49 +1100 (EST)
Date: Wed, 9 Jan 2008 12:26:44 -0600
From: Scott Wood <scottwood@freescale.com>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH 2/3 v2] Add initial iomega StorCenter board port.
Message-ID: <20080109182644.GB4337@loki.buserror.net>
References: <E1JCMbN-0002mN-MD@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1JCMbN-0002mN-MD@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 08, 2008 at 04:07:17PM -0600, Jon Loeliger wrote:
> +static void storcenter_power_off(void)
> +{
> +	/* No way to shut power off with software */
> +	local_irq_disable();
> +	for (;;) ;
> +	/* NOTREACHED */
> +}

So leave it out, and let the generic halt function be used.

-Scott
