Return-Path: <dgibson@ozlabs.org>
Date: Fri, 7 Sep 2007 10:53:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 10/10] bootwrapper: Add fsl_get_immr() and 8xx/pq2 clock
	functions.
Message-ID: <20070907005357.GI26079@localhost.localdomain>
References: <20070905192001.GA32049@ld0162-tx32.am.freescale.net>
	<20070905192119.GJ32113@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905192119.GJ32113@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 05, 2007 at 02:21:19PM -0500, Scott Wood wrote:
> fsl_get_immr() is equivalent to the kernel's get_immrbase() function.
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

Uh... doesn't this need to go in the series *before* the patch that
uses fsl_get_immr() for the pq2 code..?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
