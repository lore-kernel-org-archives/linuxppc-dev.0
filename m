Return-Path: <dgibson@ozlabs.org>
Date: Thu, 15 Feb 2007 10:17:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
Message-ID: <20070214231734.GC16279@localhost.localdomain>
References: <20070213061026.5837FDDDE9@ozlabs.org>
	<e9a2d2be6fe9006c1e2e0b65099a1854@kernel.crashing.org>
	<20070214002210.GE11491@localhost.localdomain>
	<45afe653a3f963e21e58a063c09b1b22@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45afe653a3f963e21e58a063c09b1b22@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 14, 2007 at 06:48:02PM +0100, Segher Boessenkool wrote:
> >>> +			clock-frequency = <5F5E100>; /* 100MHz FIXME: poke in zImage */
> >>> +			timebase-frequency = <5F5E100>; /* 100MHz FIXME: wrong, poke in
> >>> zImage */
> >>
> >> Can't you use decimal for these?
> >
> > dtc doesn't support decimal cells at present.  Suggest a good syntax
> > for doing it, and I'll add the feature.
> 
> d# 100000000    like is used in "real" OF?

Sorry, I don't entirely follow.  How does this sit in the context of a
dtc property definition? foo = <d# 100>;?  foo = d# 100 200;?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
