Return-Path: <bob.picco@hp.com>
Received: from mailhub.hp.com (mailhub.hp.com [192.151.27.10])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mailhub.hp.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 3AA8167B39
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 09:50:22 +1000 (EST)
From: "Bob Picco" <bob.picco@hp.com>
Date: Tue, 11 Apr 2006 19:29:44 -0400
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH 0/6] [RFC] Sizing zones and holes in an architecture
	independent manner
Message-ID: <20060411232944.GE23742@localhost>
References: <20060411103946.18153.83059.sendpatchset@skynet>
	<20060411222029.GA7743@agluck-lia64.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060411222029.GA7743@agluck-lia64.sc.intel.com>
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@ozlabs.org, ak@suse.de,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

luck wrote:	[Tue Apr 11 2006, 06:20:29PM EDT]
> On Tue, Apr 11, 2006 at 11:39:46AM +0100, Mel Gorman wrote:
> 
> > The patches have only been *compile tested* for ia64 with a flatmem
> > configuration. At attempt was made to boot test on an ancient RS/6000
> > but the vanilla kernel does not boot so I have to investigate there.
> 
> The good news: Compilation is clean on the ia64 config variants that
> I usually build (all 10 of them).
> 
> The bad (or at least consistent) news: It doesn't boot on an Intel
> Tiger either (oops at kmem_cache_alloc+0x41).
> 
> -Tony
I had a reply queued to report the same failure with
DISCONTIG+NUMA+VIRTUAL_MEM_MAP.  This was 2 CPU HP rx2600. I'll take a closer 
look at the code tomorrow. 

bob
