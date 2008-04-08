Return-Path: <dgibson@ozlabs.org>
Date: Wed, 9 Apr 2008 09:51:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Question on mpc52xx_common.c
Message-ID: <20080408235150.GA8092@localhost.localdomain>
References: <m21w5map5f.fsf@ohwell.denx.de>
	<fa686aa40804031200n4cd7aeb4g330ab3e2620680e@mail.gmail.com>
	<47FAA0A8.7050602@genesi-usa.com>
	<200804080414.42867.arnd@arndb.de>
	<fa686aa40804071925v6c7d28edna529e6122fdc9cf7@mail.gmail.com>
	<23d2e4300804071926n57746a3cj551ef38bf10486c7@mail.gmail.com>
	<47FB3CD6.2090706@genesi-usa.com>
	<fa686aa40804080752g595196det8f576df1884bac5d@mail.gmail.com>
	<20080408194517.GX13814@pengutronix.de>
	<47FBD09E.80504@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47FBD09E.80504@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 08, 2008 at 03:07:58PM -0500, Scott Wood wrote:
> Robert Schwebel wrote:
>> Well observed; isn't this the prove of the assumption that the whole
>> device tree idea is not working? It is *always* inconsistent and it is
>> *maintenance hell* because out-of-tree ports do *always* breakt because
>> of string inconsistencies. We have just ported a 8260 board from 2.6.22
>> to 2.6.25 and it is almost 100% oftree porting.
>
> There's going to be more churn in the initial stages than down the road.  
> 82xx had barely been added to arch/powerpc in 2.6.22, and there was little 
> review of the initial device tree bindings.
>
>> The ARM method of using just a device number is so much easier ...
>
> Yeah, it's so much fun to have to allocate a globally unique number for 
> every minor tweak of a board, and to have to maintain a mapping from said 
> numbers to information that is semantically equivalent to a device tree but 
> in less maintainable form in the kernel source.

And we can already do device numbers if we really want.  A bootwrapper
that identifies the board and supplies a device tree essentially does
that, and that way the device tree is maintained in sync with the
kernel.

This is why I've always had mixed feelings about merging device trees
into u-boot, rather than having them supplied by the wrapper.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
