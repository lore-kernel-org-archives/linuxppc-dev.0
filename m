Return-Path: <dgibson@ozlabs.org>
Date: Fri, 23 Mar 2007 15:17:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Hollis Blanchard <hollis@penguinppc.org>
Subject: Re: libfdt: going forward for u-boot
Message-ID: <20070323041708.GA6199@localhost.localdomain>
References: <4601C8F7.5060006@comcast.net>
	<20070322004959.GE2295@localhost.localdomain>
	<1174581726.22826.2.camel@basalt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1174581726.22826.2.camel@basalt>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 22, 2007 at 11:42:06AM -0500, Hollis Blanchard wrote:
> On Thu, 2007-03-22 at 11:49 +1100, David Gibson wrote:
> > 
> > I'm actually more inclined to just remove the #include from fdt.h
> > entirely and require users to provide the stdint types, by whatever
> > means, before they include fdt.h.  It's a bit icky, but I think it's
> > the sanest way to allow building in multiple environment. 
> 
> I agree. I've done something similar in a few places now, and it's the
> best solution I've found.

I just pushed out a new libfdt which removes the #include from fdt.h
as discussed.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
