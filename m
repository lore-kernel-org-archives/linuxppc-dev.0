Return-Path: <mpm@selenic.com>
Received: from waste.org (waste.org [66.93.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "waste.org", Issuer "waste.org" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A5512DDEE9
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 04:33:45 +1100 (EST)
Subject: Re: 2.6.24-rc8-mm1: powerpc oopses
From: Matt Mackall <mpm@selenic.com>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
In-Reply-To: <200801181823.07718.m.kozlowski@tuxland.pl>
References: <20080117023514.9df393cf.akpm@linux-foundation.org>
	<20080117162913.0323c517.akpm@linux-foundation.org>
	<1200617237.3839.32.camel@cinder.waste.org>
	<200801181823.07718.m.kozlowski@tuxland.pl>
Content-Type: text/plain
Date: Fri, 18 Jan 2008 11:33:12 -0600
Message-Id: <1200677592.3835.11.camel@cinder.waste.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-01-18 at 18:23 +0100, Mariusz Kozlowski wrote:
> Hello,
> 
> > > Do we need `offset' at all?
> > 
> > Looks like no.
> > 
> > I wonder if there's a good argument for adding a pte_offset_val() which
> > would let us do:
> > 
> > pteval = pte_offset_val(pmd, addr);
> > 
> > and shrink the map/unmap window and overhead here and possibly
> > elsewhere?
> > 
> > Anyway, updated but still untested patch now with revealing comment:
> 
> I patched the ppc32 kernel with this and run tests on /proc.
> This patch helps. No more BUGs and oopses :)

Thanks, Andrew's already queued it up.

-- 
Mathematics is the supreme nostalgia of our time.
