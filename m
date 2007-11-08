Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [1/2] dtc: Refactor printing of property values in -Odts mode 
In-Reply-To: Your message of "Wed, 07 Nov 2007 10:21:20 +1100."
	<20071106232120.GH31367@localhost.localdomain>
References: <20071106232120.GH31367@localhost.localdomain> 
Date: Thu, 08 Nov 2007 09:25:02 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Iq9Fe-0002fW-CX@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> Currently the main recursive tree printing function,
> write_tree_source_node(), calls guess_type() to apply heuristics to
> see how to print a property value, then calls the appropriate
> write_propval_*() function to print it.
> 
> However, future heuristics for handling internal labels and the like
> don't work well this way.  Therefore, this patch refactors things to
> have write_tree_source_node() call a new write_propval() function,
> which incorporates the heurstic logic from guess_type() and also calls
> the right function to do the actual printing.
> 
> No behavioural change.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
