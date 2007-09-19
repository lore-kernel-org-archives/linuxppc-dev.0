Return-Path: <dgibson@ozlabs.org>
Date: Wed, 19 Sep 2007 13:16:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 07/28] bootwrapper: Add fsl_get_immr() and 8xx/pq2 clock
	functions.
Message-ID: <20070919031604.GI23646@localhost.localdomain>
References: <20070917165643.GA6545@loki.buserror.net>
	<20070917165736.GG6563@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070917165736.GG6563@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 17, 2007 at 11:57:36AM -0500, Scott Wood wrote:
> fsl_get_immr() uses /soc/ranges to determine the immr.
> 
> mpc885_get_clock() transforms a crystal frequency into a system frequency
> according to the PLL register settings.
> 
> pq2_get_clocks() does the same as the above for the PowerQUICC II,
> except that it produces several different clocks.
> 
> The mpc8xx/pq2 set_clocks() functions modify common properties in
> the device tree based on the given clock data.
> 
> The mpc885/pq2 fixup_clocks() functions call get_clocks(), and
> pass the results to set_clocks().
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
