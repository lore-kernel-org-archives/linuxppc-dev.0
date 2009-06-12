Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 403CCB715E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 13 Jun 2009 00:20:31 +1000 (EST)
Subject: Re: linux-next: origin tree build failure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20090612140730.GJ32105@elte.hu>
References: <20090612102427.32582baa.sfr@canb.auug.org.au>
	<1244768406.7172.1.camel@pasglop> <20090612092054.GB32052@elte.hu>
	<1244799197.7172.106.camel@pasglop> <20090612125335.GH31845@elte.hu>
	<1244812224.7172.146.camel@pasglop> <20090612134428.GC32105@elte.hu>
	<1244814976.7172.164.camel@pasglop>  <20090612140730.GJ32105@elte.hu>
Content-Type: text/plain
Date: Sat, 13 Jun 2009 00:19:58 +1000
Message-Id: <1244816398.7172.172.camel@pasglop>
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


> Uhm, the bug you are making a big deal of would have been found and 
> fixed by Paulus a few hours after any such mail - and probably by me 
> too as i do daily cross builds to Power.
> 
> So yes, we had a bug, but any extra linux-next hoops would not have 
> prevented it: i could still have messed up by getting lured by that 
> nice piece of Power7 hardware enablement patch on the last day ;-)
> 
> So the bug was my fault for being too fast-and-loose with that 
> particular patch, creating a ~5-commits-hop build breakage bisection 
> window on Power.
> 
> Now that i'm sufficiently chastised, can we now move on please? :)

Sure we can :-) My point is, get a break before you merge upstream :-)

Cheers,
Ben.
