Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CEF2EB716C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 09:02:08 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 25427DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 09:02:07 +1000 (EST)
Subject: Re: [PATCH 1/6] perf_counter: powerpc: Enable use of software
	counters on 32-bit powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20090617142151.GB6846@elte.hu>
References: <19000.55404.103840.393470@cargo.ozlabs.ibm.com>
	<20090617142151.GB6846@elte.hu>
Content-Type: text/plain
Date: Fri, 19 Jun 2009 09:01:54 +1000
Message-Id: <1245366114.8693.9.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-06-17 at 16:21 +0200, Ingo Molnar wrote:
> > This depends on the generic atomic64_t patches, which are now in 
> > Linus' tree.  Ingo, if you're putting these in, please pull Linus' 
> > tree in first.
> 
> Note, i've created a new branch, tip:perfcounters/powerpc, so we can 
> keep these things separate and Ben can pull them too. I see there 
> was some review feedback - do you want to send a v2 version perhaps?

At this stage, I'm happy for you to push them. I was thinking about
moving the files around but that can wait. No serious comments on the
patches themselves on my side.

Cheers
Ben
