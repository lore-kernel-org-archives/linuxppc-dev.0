Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5C330B7B68
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 22:44:38 +1000 (EST)
Date: Wed, 23 Sep 2009 14:44:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] perf_event, powerpc: Fix compilation after big
	perf_counter rename
Message-ID: <20090923124420.GA5525@elte.hu>
References: <19128.4280.813369.589704@cargo.ozlabs.ibm.com>
	<1253584591.7103.197.camel@pasglop>
	<20090922072834.GA25470@elte.hu>
	<1253606415.7103.216.camel@pasglop>
	<1253620332.10476.4.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1253620332.10476.4.camel@concordia>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Michael Ellerman <michael@ellerman.id.au> wrote:

> On Tue, 2009-09-22 at 18:00 +1000, Benjamin Herrenschmidt wrote:
> > On Tue, 2009-09-22 at 09:28 +0200, Ingo Molnar wrote:
> > > 
> > > Nevertheless you are right that i should have caught this particular 
> > > PowerPC build bug - i missed it - sorry about that!
> > > 
> > Allright. Well, to help in general, we are setting up a build-bot
> > here too that will build -tip HEAD for at least powerpc daily with
> > a few configs too.
> 
> Results here:
> 
> http://kisskb.ellerman.id.au/kisskb/branch/12/

ok, seems green for today - the two failures are: one a powerpc 
toolchain problem it appears, plus a mainline warning.

Btw., for me to be able to notice failures there it would have to email 
me automatically if there's any -tip build failures that do not occur 
with the upstream branch. Does it have such a feature?

	Ingo
