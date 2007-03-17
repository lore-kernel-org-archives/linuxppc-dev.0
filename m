Return-Path: <dgibson@ozlabs.org>
Date: Sat, 17 Mar 2007 12:38:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 8/15] zImage: Cleanup and improve zImage entry point
Message-ID: <20070317013859.GJ3969@localhost.localdomain>
References: <20070305032307.GB31417@localhost.localdomain>
	<20070305032452.810C1DDF1B@ozlabs.org>
	<20070315230230.GB3342@mag.az.mvista.com>
	<20070316001819.GE6784@localhost.localdomain>
	<20070316004717.GB10786@mag.az.mvista.com>
	<20070316005016.GI6784@localhost.localdomain>
	<20070316162135.GA29231@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070316162135.GA29231@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 16, 2007 at 11:21:35AM -0500, Scott Wood wrote:
> On Fri, Mar 16, 2007 at 11:50:16AM +1100, David Gibson wrote:
> > Sorry, I misunderstood.  That sort of firmware - and the even dumber
> > sort where the start address isn't configurable at all - is exactly
> > what option (1) is for.  You'll need an asm platform file which
> > defines _zimage_start to a fixed offset.  In your case you could
> > probably just make it a jump to the generic _zimage_start.
> 
> One problem with that is that the wrapper currently only accepts one
> platform .o file -- and presumably one isn't going to want to do all of
> the platform code in assembly.

Um.. nobody does it yet, but I don't think there's actually any reason
that $platformo can't be set to a list of multiple .o files.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
