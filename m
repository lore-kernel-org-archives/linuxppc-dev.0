Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7154DDDE1F
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 07:14:09 +1100 (EST)
Subject: Re: [PATCH 0/9] powerpc: Preliminary work to enable SMP BookE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <6CFA99B4-6757-414F-B272-2B6925682593@freescale.com>
References: <1228714789.103940.266501677728.qpush@grosgo>
	<6CFA99B4-6757-414F-B272-2B6925682593@freescale.com>
Content-Type: text/plain
Date: Wed, 10 Dec 2008 07:12:00 +1100
Message-Id: <1228853520.22413.4.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-12-09 at 07:17 -0600, Kumar Gala wrote:

> > There are some semingly unrelated patches in the pile as they
> > are dependencies of the main ones so I'm including them in.
> 
> You'll be happy to know these patches at least boot on real 85xx SMP HW.

Ah excellent !

Now time for you to torture test them :-) BTW. Don't you guys support
larger than 8-bit PIDs on some E500 cores ? The latest patch I posted
yesterday should allow to slip than in easily too.

Cheers,
Ben.
