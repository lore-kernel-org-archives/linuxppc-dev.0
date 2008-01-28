Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 11B0BDDE34
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 00:08:32 +1100 (EST)
Date: Mon, 28 Jan 2008 13:56:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: ppc32: Weird process scheduling behaviour with 2.6.24-rc
Message-ID: <20080128125631.GA8269@elte.hu>
References: <1201244618.6815.130.camel@pasglop>
	<1201245901.6815.133.camel@pasglop>
	<1201251000.6341.108.camel@lappy>
	<20080126040734.GA21365@linux.vnet.ibm.com>
	<1201320834.6815.160.camel@pasglop>
	<20080126050757.GB14177@linux.vnet.ibm.com>
	<1201450409.1931.23.camel@thor.sulgenrain.local>
	<1201510236.6149.24.camel@lappy> <20080128123253.GA32496@elte.hu>
	<1201524796.28547.5.camel@lappy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1201524796.28547.5.camel@lappy>
Cc: linuxppc-dev@ozlabs.org,
	Michel =?iso-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>,
	vatsa@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> > i think it would be OK to do half of this: make it easier to preempt 
> > a +nice task. Michel, do you really need the -nice portion as well? 
> > It's not a problem to super-preempt positively reniced tasks, but it 
> > can be quite annoying if negatively reniced tasks have super-slices.
> 
> This should do that (unless I need a stronger cup of tea).

cool - thanks Peter. Michel, could you check Peter's patch, does it 
resolve all the interactivity problems you've been seeing?

	Ingo
