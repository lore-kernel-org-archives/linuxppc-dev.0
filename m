Return-Path: <SRS0+bd188df41afa764af17a+1799+infradead.org+dwmw2@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0A850DDF4E
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 15:40:37 +1000 (EST)
Subject: Re: [PATCH] powerpc: Use new printk extension %pS to print symbols
	on oops
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <alpine.LFD.1.10.0807071006270.11076@woody.linux-foundation.org>
References: <20080707034436.BEA2DDDF35@ozlabs.org>
	<alpine.LFD.1.10.0807071006270.11076@woody.linux-foundation.org>
Content-Type: text/plain
Date: Sun, 27 Jul 2008 01:40:30 -0400
Message-Id: <1217137231.1769.33.camel@shinybook.infradead.org>
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

On Mon, 2008-07-07 at 10:08 -0700, Linus Torvalds wrote:
> On Mon, 7 Jul 2008, Benjamin Herrenschmidt wrote:
> >
> > This changes the oops and backtrace code to use the new %pS
> > printk extension to print out symbols rather than manually
> > calling print_symbol.
> 
> Ok, I ended up committing the suppor for '%pS' early (as a series of 
> smaller patches to make it clearer), just because it makes it easier for 
> different people to start converthing things with the infrastructure in 
> place.

Out of interest, why is it %pS and not %Sp? Shouldn't the modifier come
first? What if we want to print a pointer immediately followed by a
capital S?

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
