Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4F1B3679F7
	for <linuxppc-dev@ozlabs.org>; Sun, 21 May 2006 07:41:11 +1000 (EST)
Date: Sat, 20 May 2006 14:40:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 4/6] Have x86_64 use add_active_range() and
	free_area_init_nodes
Message-Id: <20060520144043.22f993b1.akpm@osdl.org>
In-Reply-To: <200605202327.19606.ak@suse.de>
References: <20060508141030.26912.93090.sendpatchset@skynet>
	<20060508141151.26912.15976.sendpatchset@skynet>
	<20060520135922.129a481d.akpm@osdl.org>
	<200605202327.19606.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: davej@codemonkey.org.uk, tony.luck@intel.com, linux-mm@kvack.org,
	mel@csn.ul.ie, linux-kernel@vger.kernel.org, bob.picco@hp.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andi Kleen <ak@suse.de> wrote:
>
> 
> > Anyway.  From the implementation I can see what the code is doing.  But I
> > see no description of what it is _supposed_ to be doing.  (The process of
> > finding differences between these two things is known as "debugging").  I
> > could kludge things by setting MAX_ACTIVE_REGIONS to 1000000, but enough. 
> > I look forward to the next version ;)
> 
> Or we could just keep the working old code.
> 
> Can somebody remind me what this patch kit was supposed to fix or improve again? 
> 

Well, it creates arch-neutral common code, teaches various architectures
use it.  It's the sort of thing we do all the time.

These things are opportunities to eliminate crufty arch code which few
people understand and replace them with new, clean common code which lots
of people understand.  That's not a bad thing to be doing.
