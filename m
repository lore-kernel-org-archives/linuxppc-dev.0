Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 92726B7095
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 13 Jun 2009 00:07:52 +1000 (EST)
Date: Fri, 12 Jun 2009 16:07:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: linux-next: origin tree build failure
Message-ID: <20090612140730.GJ32105@elte.hu>
References: <20090612102427.32582baa.sfr@canb.auug.org.au>
	<1244768406.7172.1.camel@pasglop> <20090612092054.GB32052@elte.hu>
	<1244799197.7172.106.camel@pasglop>
	<20090612125335.GH31845@elte.hu>
	<1244812224.7172.146.camel@pasglop>
	<20090612134428.GC32105@elte.hu>
	<1244814976.7172.164.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1244814976.7172.164.camel@pasglop>
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

> On Fri, 2009-06-12 at 15:44 +0200, Ingo Molnar wrote:
> 
> > This is certainly doable for agreeable features - which is the bulk 
> > - and it is being done.
> > 
> > But this is a catch-22 for _controversial_ new features - which 
> > perfcounters clearly was, in case you turned off your lkml 
> > subscription ;-)
> 
> I didn't :-) My point here is that Linus can make a decision with 
> an email -before- merging so that -next gets a chance, at least 
> for a couple of days, to do the integration testing once the 
> controversy has been sorted by his highness.

Uhm, the bug you are making a big deal of would have been found and 
fixed by Paulus a few hours after any such mail - and probably by me 
too as i do daily cross builds to Power.

So yes, we had a bug, but any extra linux-next hoops would not have 
prevented it: i could still have messed up by getting lured by that 
nice piece of Power7 hardware enablement patch on the last day ;-)

So the bug was my fault for being too fast-and-loose with that 
particular patch, creating a ~5-commits-hop build breakage bisection 
window on Power.

Now that i'm sufficiently chastised, can we now move on please? :)

	Ingo
