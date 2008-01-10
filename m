Return-Path: <dgibson@ozlabs.org>
Date: Thu, 10 Jan 2008 17:02:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: How complete should the DTS be?
Message-ID: <20080110060245.GE19088@localhost.localdomain>
References: <4782DAD8.1080104@pikatech.com>
	<86AA8535-E2CF-4891-900B-340049A5CA19@kernel.crashing.org>
	<20080110031331.GF17816@localhost.localdomain>
	<4785B2F5.6040001@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4785B2F5.6040001@pikatech.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 10, 2008 at 12:53:57AM -0500, Sean MacLennan wrote:
> David Gibson wrote:
> > Hrm... I'd say this is not something which has a firm convention yet.
> > It's going to become more of an issue once we get a macros system for
> > dtc, so the "440EP" macro would have all the devices, even if some are
> > not connected on a given board.
> >
> > I'm contemplating suggesting that we adopt the "status" property from
> > IEEE1275 to cover this.
> >
> >   
> When I am laying out the dts, leaving out what isn't used makes the dts 
> file cleaner, at least in my view. It doesn't hurt to have the second 
> i2c bus there, but it also doesn't help and leaving it out points out 
> that it is not used.
> 
> When we get a macro system I assume the second i2c bus will be there but 
> hidden by a macro. It will still be clean and shouldn't cause grief.

Right, but if it is there we'll want to mark it as unused in some way
so that the kernel doesn't waste resources attempting to drive it.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
