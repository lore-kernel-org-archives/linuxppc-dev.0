Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 21784DDEB7
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 03:39:49 +1100 (EST)
Date: Mon, 26 Nov 2007 10:39:56 -0600
From: Scott Wood <scottwood@freescale.com>
To: Joel Rouch <joel@fabiotec.com>
Subject: Re: sys_mpc83xx spi driver not probed
Message-ID: <20071126163956.GB4408@loki.buserror.net>
References: <4747079F.60703@fabiotec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4747079F.60703@fabiotec.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 23, 2007 at 07:02:23PM +0200, Joel Rouch wrote:
> I have a custom 8349 ppc board. I have defined the spi master in the 
> configuration.
> While booting my board, I driver is well added and linked to platform 
> bus, however I don't see that the probe entry point is reached.
> I don't succeed to understand who is triggering the probe. Can someone 
> point me to the right link or explain me how to force it ?

Are you calling of_platform_bus_probe() from your board file?

-Scott
