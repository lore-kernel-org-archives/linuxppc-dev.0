Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C51C9B7173
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 13 Jun 2009 00:23:27 +1000 (EST)
Subject: Re: linux-next: origin tree build failure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20090612141118.GK32105@elte.hu>
References: <20090612102427.32582baa.sfr@canb.auug.org.au>
	<1244768406.7172.1.camel@pasglop> <20090612092054.GB32052@elte.hu>
	<1244799197.7172.106.camel@pasglop> <20090612125335.GH31845@elte.hu>
	<1244812224.7172.146.camel@pasglop> <1244813397.7172.156.camel@pasglop>
	<20090612134940.GD32105@elte.hu> <1244815574.7172.171.camel@pasglop>
	<20090612141118.GK32105@elte.hu>
Content-Type: text/plain
Date: Sat, 13 Jun 2009 00:23:02 +1000
Message-Id: <1244816582.7172.175.camel@pasglop>
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

On Fri, 2009-06-12 at 16:11 +0200, Ingo Molnar wrote:
> > Maybe. But maybe it's representative... so far in this merge 
> > window, 100% of the powerpc build and runtime breakage upstream 
> > comes from stuff that didn't get into -next before.
> 
> But that's axiomatic, isnt it? linux-next build-tests PowerPC as the 
> first in the row of tests - so no change that was in linux-next can 
> ever cause a build failure on PowerPC, right?

I'd have to check with Stephen but I think linux-next tests a whole
bunch of archs each round. Anyway, the idea is, just don't get things
upstream before the at least had a chance to go through that little bit
of integration testing .. Is it -that- hard ?

Oh and before you ask me, yes, I do the same mistakes, and I have been
caught too merging things at the last minute that ended up broken and
that could have been caught by -next... I'm just trying to advocate the
idea that we all try to improve in that area :-)

Cheers,
Ben.
