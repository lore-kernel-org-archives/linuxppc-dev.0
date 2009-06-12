Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BE3B3B71DB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 19:33:46 +1000 (EST)
Subject: Re: linux-next: origin tree build failure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20090612092054.GB32052@elte.hu>
References: <20090612102427.32582baa.sfr@canb.auug.org.au>
	<1244768406.7172.1.camel@pasglop>  <20090612092054.GB32052@elte.hu>
Content-Type: text/plain
Date: Fri, 12 Jun 2009 19:33:17 +1000
Message-Id: <1244799197.7172.106.camel@pasglop>
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


> Ah - thanks. The bug was caused by me being a bit too optimistic in 
> applying the shiny-new Power7 support patches on the last day. (nice 
> CPU btw.)

In that case paulus tells me it's actually Peter screwing up moving
something from the powerpc code to generic :-)

 .../...

> Such bugs happen, and they are easy enough to fix. What matters 
> arent the 1-2 short-lived bugs that do happen when a new combination 
> of trees is created, but the long-lived combination bugs and 
> conflicts.

I'm not saying -next would fix world hunger ... but in this case we have
two sets of issues, perfctr and the init ordering change which both got
merged totally bypassing -next... We should at least -try- to follow the
process we've defined, don't you think ?

Cheers,
Ben.
