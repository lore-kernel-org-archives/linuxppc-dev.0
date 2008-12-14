Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id D8AE9DDF5A
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Dec 2008 10:19:29 +1100 (EST)
Date: Sun, 14 Dec 2008 17:19:20 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] add of_find_next_cache_node()
Message-ID: <20081214231919.GO6958@localdomain>
References: <1228956366-17593-1-git-send-email-ntl@pobox.com>
	<1229296287.26324.87.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1229296287.26324.87.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2008-12-10 at 18:46 -0600, Nathan Lynch wrote:
> > +       /* OF on pmac has nodes instead of properties named "l2-cache"
> > +        * beneath CPU nodes.
> > +        */
> > +       if (!strcmp(np->type, "cpu"))
> > +               for_each_child_of_node(np, child)
> > +                       if (!strcmp(child->type, "cache"))
> > +                               return child;
> > +
> 
> pmac has both actually. And the property points to the node. It's a
> problem for /proc/device-tree so we rename them iirc, but only in /proc,
> ie, they should still be intact in the tree I think.

Okay, I'll check on this.
