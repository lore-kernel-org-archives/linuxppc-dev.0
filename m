Return-Path: <dgibson@ozlabs.org>
Date: Tue, 5 Jun 2007 11:26:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] Replace use of GET_64BIT(prop, i) with of_read_number().
Message-ID: <20070605012605.GA22680@localhost.localdomain>
References: <1180988658.9632.38.camel@ld0161-tx32>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1180988658.9632.38.camel@ld0161-tx32>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, Jun 04, 2007 at 03:24:18PM -0500, Jon Loeliger wrote:
> Remove uses of hack GET_64BIT() property macro and use
> the more general of_read_number() function from prom.h
> as suggested by Milton.
> 
> Signed-off-by: Jon Loeliger <jdl@freescale.com>
> ---
> 
> Someone in 64-bit land please check this!
> I have no board on which to test this.  Sorry.

Gave it a brief whirl on a POWER5 LPAR.  Seems ok.

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
