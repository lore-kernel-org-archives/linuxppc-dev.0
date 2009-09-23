Return-Path: <dgibson@ozlabs.org>
Date: Wed, 23 Sep 2009 10:03:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: powerpc: Move 64bit heap above 1TB on machines with 1TB segments
Message-ID: <20090923000314.GB26739@yookeroo.seuss>
References: <20090922025235.GD31801@kryten>
	<OFE590BAE9.6FD7FAB3-ON80257639.0050F8A6-80257639.00514A5E@ie.ibm.com>
	<1253653702.7103.244.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1253653702.7103.244.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, Mel Gorman <MELGOR@ie.ibm.com>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 23, 2009 at 07:08:22AM +1000, Benjamin Herrenschmidt wrote:
> 
> > Unfortunately, I am not sensitive to issues surrounding 1TB segments or how
> > they are currently being used. However, as this clearly helps performance
> > for large amounts of memory, is it worth providing an option to
> > libhugetlbfs to locate 16MB pages above 1TB when they are otherwise being
> > unused?
> 
> AFAIK, that is already the case, at least the kernel will hand out pages
> above 1T preferentially iirc.
> 
> There were talks about making huge pages below 1T not even come up
> untily you ask for them with MAP_FIXED, dunno where that went.

That was already the case as far as I remember.  But it's just
possible that changed when the general slice handling code came in,

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
