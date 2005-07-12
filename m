Return-Path: <dgibson@ozlabs.org>
Date: Tue, 12 Jul 2005 14:06:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Message-ID: <20050712040623.GG3945@localhost.localdomain>
References: <1120859097.8609.15.camel@cashmere.sps.mot.com>
	<20050711045532.GC32545@localhost.localdomain>
	<1121116950.15394.14.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1121116950.15394.14.camel@cashmere.sps.mot.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: PATCH: Add memreserve to DTC
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 11, 2005 at 04:22:30PM -0500, Jon Loeliger wrote:
> On Sun, 2005-07-10 at 23:55, David Gibson wrote:
> > On Fri, Jul 08, 2005 at 04:44:58PM -0500, Jon Loeliger wrote:
[snip]
> > Biggest thing is that rather than passing the tree itself and the
> > memreserve info about as two parameters all over the place, I'd rather
> > create a new structure which has both (and later can have anything
> > else that might be needed).
> 
> If you'd like, I'll do this work.

That would be helpful.  You'll need to rediff, though, I merged a
couple of bugfixes from your patch that weren't directly related to
the memreserve stuff.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
