Return-Path: <mingo@elte.hu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0B23CB7250
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Jun 2009 20:32:28 +1000 (EST)
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8FD18DDD0C
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jun 2009 20:32:26 +1000 (EST)
Date: Sat, 20 Jun 2009 12:32:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/6] perf_counter: powerpc: Enable use of software
	counters on 32-bit powerpc
Message-ID: <20090620103206.GA13814@elte.hu>
References: <19000.55404.103840.393470@cargo.ozlabs.ibm.com>
	<20090617142151.GB6846@elte.hu>
	<8C6954A9-BE4C-47F5-AD87-A1D0EAF43F8A@kernel.crashing.org>
	<20090617142719.GC6846@elte.hu> <1245366204.8693.11.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1245366204.8693.11.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2009-06-17 at 16:27 +0200, Ingo Molnar wrote:
> > I think it would be nice to have more platform support in .31. 
> > Perfcounters is a brand-new feature so there's no risk of 
> > regression. In the end it will depend on Linus to pull of course, 
> > and BenH can veto it too if he'd like no more PowerPC changes in 
> > this cycle. Worst-case it's all .32 material.
> 
> There have been little PowerPC changes in this cycle and I agree 
> with you on that it's a nice feature to have with little risk of 
> regression.

Ok - thanks - i'll push it to Linus probably later today.

> In fact, I also have an up-to-date (and hopefully working) 
> irqtrace/lockdep patch for 32-bit powerpc (we only do 64-bit right 
> now) that I'm considering merging this time around, the benefit it 
> brings is worth the risk I believe.

Nice :-)

	Ingo
