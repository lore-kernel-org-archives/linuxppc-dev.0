Return-Path: <dgibson@ozlabs.org>
Date: Fri, 10 Aug 2007 11:02:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v3 1/2] [POWERPC] MPC832x_RDB: update dts to use spi,
	register mmc_spi stub
Message-ID: <20070810010217.GA17370@localhost.localdomain>
References: <20070808170728.GA21118@localhost.localdomain>
	<20070808170921.GA21487@localhost.localdomain>
	<20070809030752.GB8261@localhost.localdomain>
	<af4642f6ed6a4bc167161ac73ad75350@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <af4642f6ed6a4bc167161ac73ad75350@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 09, 2007 at 10:15:44PM +0200, Segher Boessenkool wrote:
> > Hrm... Freescale is using these 'fsl,device-id' properties, I'm
> > guessing they're basically the same thing as the 'cell-index' used in
> > the EMAC binding.
> >
> > We should co-ordinate better on this, if it's to become a
> > convention...
> 
> That means we shouldn't coordinate on this, right?

Heh.  Either one is kind of ugly, I'll grant you.

But, many SoCs do have a notion of device "number", which is relevant
for programming other general control registers in places.  We need to
encode it somehow, and it would be good to have a consistent way of
doing it.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
