Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3CF83686AD
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2005 17:00:39 +1100 (EST)
Date: Wed, 9 Nov 2005 22:00:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <20051109220022.264437f8.akpm@osdl.org>
In-Reply-To: <1131601224.24637.155.camel@gaston>
References: <20051109072228.GA7983@pb15.lixom.net>
	<1131526855.24637.67.camel@gaston>
	<20051109213837.47c8dce7.akpm@osdl.org>
	<1131601224.24637.155.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc: add support for new powerbooks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> 
> > I don't think I'm adding much value handling ppc/ppc64 patches, really. 
> > I'd prefer to get out of that business.
> > 
> > It would be better to have an arch maintainer who runs a git tree, same as
> > ia64, arm, etc.
> > 
> > And, given the amount of shared infrastructure, I suspect it would have to
> > be a single git tree for both architectures.
> > 
> > I'd still sweep up random ppc patches, but those will go into mainline via the
> > originator->mm->git-powerpc->linus route.
> > 
> > Possible?
> 
> Well, I'm personally no fan of the git route as it causes us to have
> less review on the list imho

Well yes, that's a generic problem with subsystem trees.  I suppose one
could enforce processes which prevent it from happening.

> (too easy also for me to just bounce a
> patch to paulus to shove in his git tree :) though that's what I've been
> doing for the last few days at least. But if you prefer that way, yes,
> it's certainly possible.

OK, well please think about it.  It's not a ton of work at this end at
present, but a) you lazy bums don't ack most of the things I cc you on, so
it's rather open-loop and I don't know whether I'm merging wrong patches
and b) there's now increasing potential for patches in -mm to clash with
patches in Paul's git tree.

The latter can be solved easily enough: I add Paul's git tree to the -mm
lineup.   Gimme.
