Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1C8B7DDD04
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jul 2008 09:00:31 +1000 (EST)
Subject: Re: the printk problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <alpine.LFD.1.10.0807041250220.2815@woody.linux-foundation.org>
References: <20080625131101.GA6205@digi.com> <20080704104634.GA31634@digi.com>
	<20080704111540.ddffd241.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0807041147450.2815@woody.linux-foundation.org>
	<alpine.LFD.1.10.0807041250220.2815@woody.linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Date: Sat, 05 Jul 2008 09:00:20 +1000
Message-Id: <1215212420.8970.8.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-ia64@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Peter Anvin <hpa@zytor.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-07-04 at 13:02 -0700, Linus Torvalds wrote:
> 
> That function descriptor indirection is totally untested, and I did it 
> with a
> 
>         pagefault_disable();
>         __get_user(..)
>         pagefault_enable();
> 
> thing because I thought it would be nice if printk() was always safe, and 
> passing bogus function pointers to '%pF' should try to work, but quite 
> frankly, I didn't even check that that part compiles, much less works.
> 
> ia64/ppc lists cc'd, just in case somebody wants to test this.

I'll give it a try using ﻿probe_kernel_address() instead on monday.

Cheers,
Ben.
