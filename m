Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D8709B71E6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 23:49:59 +1000 (EST)
Date: Fri, 12 Jun 2009 15:49:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: linux-next: origin tree build failure
Message-ID: <20090612134940.GD32105@elte.hu>
References: <20090612102427.32582baa.sfr@canb.auug.org.au>
	<1244768406.7172.1.camel@pasglop> <20090612092054.GB32052@elte.hu>
	<1244799197.7172.106.camel@pasglop>
	<20090612125335.GH31845@elte.hu>
	<1244812224.7172.146.camel@pasglop>
	<1244813397.7172.156.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1244813397.7172.156.camel@pasglop>
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


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Fri, 2009-06-12 at 23:10 +1000, Benjamin Herrenschmidt wrote:
> > On Fri, 2009-06-12 at 14:53 +0200, Ingo Molnar wrote:
> 
> > To some extent, here, the issue is on Linus side and it's up to him (Hey
> > Linus ! still listening ?) to maybe be more proactive at giving an ack
> > or nack so that we can get a chance to do that final pass of ironing out
> > the mechanical bugs before we hit the main tree.
> 
> Let me add a little bit more background to my reasoning here and why I
> think having this integration testing step is so valuable...
> 
> It all boils down to bisection and having a bisectable tree.

I think you are way too concentrated on this particular incident, 
and you are generalizing it into something that is not so in 
practice.

Even in this particular case, there's just 3 other commit points in 
the Git tree between commit 8a1ca8c (the breakage on PowerPC) and 
e14112d (the fix). We'll have up to 10,000 commits.

I bisect on an almost daily basis, and i'm not seeing unreasonable 
problems.

	Ingo
