Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6D377DDE0F
	for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2008 10:49:18 +1000 (EST)
Subject: Re: how to check for "optional" ppc chip features (MSR_BE)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland McGrath <roland@redhat.com>
In-Reply-To: <20080504231207.8377E26FA08@magilla.localdomain>
References: <20080502012118.96ED926FA07@magilla.localdomain>
	<DC173CDE-FBC4-4EA0-8022-3F993B6466BF@kernel.crashing.org>
	<1209937549.21644.2.camel@pasglop>
	<20080504231207.8377E26FA08@magilla.localdomain>
Content-Type: text/plain
Date: Mon, 05 May 2008 10:49:10 +1000
Message-Id: <1209948550.21644.30.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2008-05-04 at 16:12 -0700, Roland McGrath wrote:
> > Oh and classic pitfall: If you define a new feature bit, make sure
> > CPU_FTRS_POSSIBLE is updated to contain it in cputable.h
> 
> Yeah, all that stuff I could figure out as needed.  What I really meant
> was, where is the big official table of which chips behave which ways that
> you base all code that on?

There isn't any ...

> Actually, I don't really care as long as you
> all are happy to be responsible for figuring out what matters.  With the
> patch I posted to use MSR_BE, I took Kumar Gala's word as gospel that all
> the chips on which we use MSR_SE also have MSR_BE.  If that's not right,
> then I hope you'd like to pick a feature bit, populate the tables, etc.,
> and fix the definition of arch_has_block_step() as appropriate.

I'll have to check with Paul, we'll scrub the IBM parts, and Kumar can
dbl check the "classic 32" FSL parts.

Ben.
