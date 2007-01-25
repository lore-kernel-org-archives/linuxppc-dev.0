Return-Path: <dgibson@ozlabs.org>
Date: Thu, 25 Jan 2007 13:21:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 01/18] Include autoconf.h from the bootwrapper.
Message-ID: <20070125022111.GD26212@localhost.localdomain>
References: <20070124210654.GA10527@ld0162-tx32.am.freescale.net>
	<20070124235150.GA26212@localhost.localdomain>
	<56B86A8F-4E40-4C58-A774-0DE3C7AA8CE2@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56B86A8F-4E40-4C58-A774-0DE3C7AA8CE2@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 24, 2007 at 08:08:02PM -0600, Kumar Gala wrote:
> 
> On Jan 24, 2007, at 5:51 PM, David Gibson wrote:
> 
> > On Wed, Jan 24, 2007 at 03:06:54PM -0600, Scott Wood wrote:
> >> This will be required by the u-boot compatibility code to obtain a
> >> compatible bd_t layout, to determine how to calculate the  
> >> timebase, and
> >> to know what soc fields need to be modified.
> >
> > Erm.. I believe the omission of *all* kernel header files from the
> > boot wrapper code, including the config, is a deliberate decision.
> > The idea is that the wrapping can, if necessary, be done independent
> > of the kernel build.
> 
> I think the problem is how to resolve the variations of the u-boot/ 
> ppcboot bd_t that changes from board to board and based on config.

Don't do that.  We're trying to get rid of this config dependant crap
that means the kernel must be built for a single board.  Instead make
the different bd_t options different options to the wrapper script.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
