Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D2AB1B721B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 19:58:04 +1000 (EST)
Subject: Re: linux-next: origin tree build failure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <1244799786.6691.1133.camel@laptop>
References: <20090612102427.32582baa.sfr@canb.auug.org.au>
	<1244768406.7172.1.camel@pasglop>  <20090612092054.GB32052@elte.hu>
	<1244799197.7172.106.camel@pasglop> <1244799786.6691.1133.camel@laptop>
Content-Type: text/plain
Date: Fri, 12 Jun 2009 19:57:15 +1000
Message-Id: <1244800635.7172.114.camel@pasglop>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	paulus@samba.org, Ingo Molnar <mingo@elte.hu>,
	Linus <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-06-12 at 11:43 +0200, Peter Zijlstra wrote:
> On Fri, 2009-06-12 at 19:33 +1000, Benjamin Herrenschmidt wrote:
> > We should at least -try- to follow the
> > process we've defined, don't you think ?
> 
> So you're saying -next should include whole new subsystems even though
> its not clear they will be merged?

Maybe yes. And if there's some debate as to whether it should be merged
or not, maybe Linus should make the decision, let -next carry it for a
few days to iron out those problems, and -then- merge it.

> That'll invariably create the opposite case where a tree doesn't get
> pulled and breaks bits due to its absence.
> 
> -next does a great job of sorting the existing subsystem trees, but I
> don't think its Stephens job to decide if things will get merged.

No, it's not, but then, maybe Linus could play the game and -tell- us
whether he intend to merge or not at least a few days in advance :-)

> Therefore when things are in limbo (there was no definite ACK from Linus
> on perf counters) both inclusion and exclusion from -next can lead to
> trouble.

Well, Linus did ACK by merging :-) So he should have been able to give
that ack a few days in advance too..

Cheers,
Ben.
