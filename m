Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0C24BDDEFF
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 23:44:07 +1000 (EST)
Date: Thu, 6 Sep 2007 08:43:54 -0500
From: Scott Wood <scottwood@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: "atomic" 64-bit math on 32-bit ppc's?
Message-ID: <20070906134354.GA16153@ld0162-tx32.am.freescale.net>
References: <46DD3CE2.4060301@genesi-usa.com> <20070904113937.GA3994@iram.es>
	<20070904184810.GG18280@ld0162-tx32.am.freescale.net>
	<e1d766f8390851a75a6fe83800484ab7@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e1d766f8390851a75a6fe83800484ab7@kernel.crashing.org>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 06, 2007 at 03:21:36PM +0200, Segher Boessenkool wrote:
> >>That's wrong if lock is assigned to r0, you should use
> >>a "b" constraint to avoid this. Same for atomic_dec below.
> >
> >GCC should really have removed r0 from the "r" class (it isn't truly a
> >general-purpose register), and had a different class meaning 
> >"r"-plus-r0.
> 
> Nah, GPR0 _is_ a general purpose register, you just cannot use all
> general purpose registers as base registers ;-)

Bah.

> Either way, it's a bit late to change this, no?

Sure, I was just whining due to having been bitten by this sort of bug in
the past. :-)

-Scott
