Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] DTC: Remove the need for the GLR Parser. 
In-Reply-To: Your message of "Tue, 23 Oct 2007 09:24:52 CDT."
	<E1IkKge-00060g-2l@jdl.com>
References: <E1Ik4aw-0007ud-Lu@jdl.com>
	<20071023025412.GI31839@localhost.localdomain>
	<E1IkKge-00060g-2l@jdl.com>
Date: Tue, 23 Oct 2007 11:07:39 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IkMI8-0000b3-0U@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Jon Loeliger mumbled:
> 
> > First, a trivial one: I remember leaving this as a right-recursion,
> > despite the stack-nastiness, because that way the properties end up in
> > the same order as in the source.  I think that behaviour is worth
> > preserving, but of course we can do it with left-recursion by changing
> > chain_property() to add to the end of the list instead of the
> > beginning.
> 
> Understood.  And I wrestled with that as well.  In fact, I even
> wrote the reverse_properties() function, which I will include,
> and used it initially.  However, several test failed.  So I
> removed it, and it all started happily working again.

I was confused.  It was the version of the code that _did_
use the property reversal that worked.

Even Milton's asm test with labels worked. :-)

jdl
