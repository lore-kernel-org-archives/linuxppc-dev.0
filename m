Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 60C08B7BD2
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Oct 2009 17:42:23 +1000 (EST)
Date: Thu, 1 Oct 2009 09:42:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] perf_event, powerpc: Fix compilation after big
	perf_counter rename
Message-ID: <20091001074201.GA6300@elte.hu>
References: <19128.4280.813369.589704@cargo.ozlabs.ibm.com>
	<1253584591.7103.197.camel@pasglop>
	<20090922072834.GA25470@elte.hu>
	<1253606415.7103.216.camel@pasglop>
	<1253620332.10476.4.camel@concordia>
	<20090923124420.GA5525@elte.hu> <1253747995.6110.5.camel@concordia>
	<20090924121423.GB12262@elte.hu>
	<1253798755.16237.4.camel@concordia>
	<20090925095841.8578073a.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090925095841.8578073a.sfr@canb.auug.org.au>
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


* Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Ingo,
> 
> On Thu, 24 Sep 2009 23:25:55 +1000 Michael Ellerman <michael@ellerman.id.au> wrote:
> >
> > Give me a day or two, I should be able to add a per-branch setting for
> > who to send mails to without too much trouble.
> 
> In the mean time I don't now if someone has pointed you at these today:
> 
> http://kisskb.ellerman.id.au/kisskb/branch/12/

That's an upstream warning.

-tip supports fail-on-build-warnings build mode (for the whole kernel) 
via the CONFIG_ALLOW_WARNINGS .config setting. So if you do allnoconfig 
builds, make sure you turn on CONFIG_ALLOW_WARNINGS=y to get the same 
build behavior as with Linus's tree.

	Ingo
