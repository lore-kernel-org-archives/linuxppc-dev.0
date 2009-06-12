Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 78A70B71A1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 23:11:14 +1000 (EST)
Subject: Re: linux-next: origin tree build failure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20090612125335.GH31845@elte.hu>
References: <20090612102427.32582baa.sfr@canb.auug.org.au>
	<1244768406.7172.1.camel@pasglop> <20090612092054.GB32052@elte.hu>
	<1244799197.7172.106.camel@pasglop>  <20090612125335.GH31845@elte.hu>
Content-Type: text/plain
Date: Fri, 12 Jun 2009 23:10:24 +1000
Message-Id: <1244812224.7172.146.camel@pasglop>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	paulus@samba.org, Linus <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-06-12 at 14:53 +0200, Ingo Molnar wrote:
> * Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> linux-next has integration testing so that interactions between 
> maintainer trees are mapped and that architectures that otherwise 
> few people use get build-tested too (well beyond their practical 
> relevance, i have to add) - but there's little critical review done 
> in linux-next. Nor should it be the forum for that, it simply 
> contains way too much stuff and has a weird history format with 
> daily rebases that makes review hard and expensive in that form.

I think you are mixing several issues. One is integration testing, one
is the problem of remote architecture of subsystems testing...

> linux-next should not be second-guessing maintainers and should not 
> act as an "approval forum" for controversial features, increasing 
> the (already quite substantial) pressure on maintainers to apply 
> more crap.

I agree here. That's not the point. The idea is that for things that
-are- approved by their respective maintainers, to get some integration
testing and ironing of those mechanical bugs so that by the time they
hit mainstream, they don't break bisection among others.

Yes, next is -not- the place to debate controversial features. That's
not, I believe, why it was initiated (I may be wrong, Stephen will
correct me if I am), but the way I see things is that stuff that is
meant to be merged gets a chance to get some of that integration testing
against all the other stuff that is also meant to be merged to limit the
amount of clash and problems once we hit Linus tree.

> And that is true even if it's a new feature that i happen to support 
> - as in this case - it sure would have been handy to have more 
> perfcounters test coverage, every little bit of extra testing helps.

That doesn't invalidate my point. We are not talking about whether
perfcounters is worth merging or not, testing more or not, but strictly,
imho, about getting a chance (a couple of days at least) to do that
integration testing and catch the simple issues like the one that
triggered my initial rant -before- they hit mainline.

To some extent, here, the issue is on Linus side and it's up to him (Hey
Linus ! still listening ?) to maybe be more proactive at giving an ack
or nack so that we can get a chance to do that final pass of ironing out
the mechanical bugs before we hit the main tree.

Cheers,
Ben.

> If linux-next wants to do that then it should be renamed to 
> something else and not called linux-next.
> 
> 	Ingo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
