Return-Path: <dgibson@ozlabs.org>
Date: Tue, 23 Oct 2007 10:33:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH 4/4] DTC: Begin the path to sane literals and expressions.
Message-ID: <20071023003309.GE31839@localhost.localdomain>
References: <E1Iivsg-00078a-Vp@jdl.com>
	<20d6133a9294d4f06a7e78ca627ec4f3@kernel.crashing.org>
	<E1IjwWf-0000dJ-45@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1IjwWf-0000dJ-45@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 22, 2007 at 07:36:57AM -0500, Jon Loeliger wrote:
> So, like, the other day Segher Boessenkool mumbled:
> > > Property names have been limited to start with
> > > characters from the set [a-zA-Z,._#?].  That is, the
> > > digits and the expression symbols have been removed.
> > 
> > This cannot work; many property names start with a digit,
> > for example.
> 
> Are any of those property names in use in any
> of our DTS files or b-w-o.txt?  Not really, no.
> In fact, with this lexical change, all of our
> DTS files still produce byte-identical results.
> 
> I really think this is one of those areas where
> we may need to stray from the other guideline.
> 
> Is there a compelling reason somewhere?  Really?

We may have deprecated te '64-bit' and '32-64-bridge' properties in
cpu nodes for the flattened tree, but it already exists in a great
number of Apple and IBM trees.  It would be poor form for dtc to choke
on these trees.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
