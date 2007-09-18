Return-Path: <dgibson@ozlabs.org>
Date: Tue, 18 Sep 2007 16:48:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 24/28] mpc82xx: Remove a bunch of cruft that duplicates
	generic functionality.
Message-ID: <20070918064812.GG30766@localhost.localdomain>
References: <20070917165643.GA6545@loki.buserror.net>
	<20070917165816.GX6563@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070917165816.GX6563@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 17, 2007 at 11:58:16AM -0500, Scott Wood wrote:
> m82xx_calibrate_decr(), mpc82xx_ads_show_cpuinfo(), and mpc82xx_halt() do
> anything useful beyond what the generic code does.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
