Return-Path: <dgibson@ozlabs.org>
Date: Mon, 17 Sep 2007 13:24:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] DTS cleanup
Message-ID: <20070917032430.GH32725@localhost.localdomain>
References: <Pine.LNX.4.64.0709121154120.19816@blarg.am.freescale.net>
	<919c9b76c3e6e45af6e3fb887611a681@kernel.crashing.org>
	<8FFFBF2E-8255-40FB-836D-AB5B19222DD9@kernel.crashing.org>
	<39e2f86a62574776183feb82935cd79c@kernel.crashing.org>
	<B89BC392-2366-42E0-BEA0-4A781A9437D3@kernel.crashing.org>
	<46EAB69C.104@freescale.com>
	<44C67E7D-CF8F-4B14-A883-4632CCE99D1A@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44C67E7D-CF8F-4B14-A883-4632CCE99D1A@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 14, 2007 at 01:11:07PM -0500, Kumar Gala wrote:
> 
> On Sep 14, 2007, at 11:28 AM, Jon Loeliger wrote:
> 
> > Kumar Gala wrote:
> >
> >> Someone really needs to add some macro/preprocessor magic into DTC  
> >> so  this is made a lot simpler.
> >> - k
> >
> > Kumar,
> >
> > I am seriously contemplating this problem.
> > The trick is, I need to quit with the whole
> > Power Point Programmer job title for a bit...
> 
> I'm all for both of these things.  You working on getting DTC to have  
> some macro/include ability and you not being a powerpoint
> programmer.

Maybe we should make some time for all of us to get on IRC together to
discuss this?

I had some thoughts on what I think is a reasonably sane variable /
expression system for dtc.  Not quite the same thing as a macro
system, but a good start on one.

Although I also think we should still consider if using m4 as a
preprocessor (with some preloaded macros) could be sufficient.  Adding
expression and macro functions to dtc itself would be rather a lot of
work.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
