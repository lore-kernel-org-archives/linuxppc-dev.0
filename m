Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6EBE3B729E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 09:03:42 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BDC00DDD1C
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 09:03:41 +1000 (EST)
Subject: Re: [PATCH 1/6] perf_counter: powerpc: Enable use of software
	counters on 32-bit powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20090617142719.GC6846@elte.hu>
References: <19000.55404.103840.393470@cargo.ozlabs.ibm.com>
	<20090617142151.GB6846@elte.hu>
	<8C6954A9-BE4C-47F5-AD87-A1D0EAF43F8A@kernel.crashing.org>
	<20090617142719.GC6846@elte.hu>
Content-Type: text/plain
Date: Fri, 19 Jun 2009 09:03:24 +1000
Message-Id: <1245366204.8693.11.camel@pasglop>
Mime-Version: 1.0
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

On Wed, 2009-06-17 at 16:27 +0200, Ingo Molnar wrote:
> I think it would be nice to have more platform support in .31. 
> Perfcounters is a brand-new feature so there's no risk of 
> regression. In the end it will depend on Linus to pull of course, 
> and BenH can veto it too if he'd like no more PowerPC changes in 
> this cycle. Worst-case it's all .32 material.

There have been little PowerPC changes in this cycle and I agree
with you on that it's a nice feature to have with little risk of
regression.

In fact, I also have an up-to-date (and hopefully working)
irqtrace/lockdep patch for 32-bit powerpc (we only do 64-bit right now)
that I'm considering merging this time around, the benefit it brings is
worth the risk I believe.

Cheers,
Ben.
