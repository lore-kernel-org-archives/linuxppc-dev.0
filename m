Return-Path: <nickpiggin@yahoo.com.au>
Received: from smtp102.mail.mud.yahoo.com (smtp102.mail.mud.yahoo.com
	[209.191.85.212]) by ozlabs.org (Postfix) with SMTP id D790E67A67
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 00:11:31 +1000 (EST)
Message-ID: <443B8DE7.4000900@yahoo.com.au>
Date: Tue, 11 Apr 2006 21:07:19 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH 6/6] Break out memory initialisation code from page_alloc.c
	to mem_init.c
References: <20060411103946.18153.83059.sendpatchset@skynet>
	<20060411104147.18153.64342.sendpatchset@skynet>
In-Reply-To: <20060411104147.18153.64342.sendpatchset@skynet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: davej@codemonkey.org.uk, tony.luck@intel.com, ak@suse.de,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mel Gorman wrote:
> page_alloc.c contains a large amount of memory initialisation code. This patch
> breaks out the initialisation code to a separate file to make page_alloc.c
> a bit easier to read.
> 

Seems like a very good idea to me.

> +/*
> + * mm/mem_init.c
> + * Initialises the architecture independant view of memory. pgdats, zones, etc
> + *
> + *  Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
> + *  Swap reorganised 29.12.95, Stephen Tweedie
> + *  Support of BIGMEM added by Gerhard Wichert, Siemens AG, July 1999
> + *  Reshaped it to be a zoned allocator, Ingo Molnar, Red Hat, 1999
> + *  Discontiguous memory support, Kanoj Sarcar, SGI, Nov 1999
> + *  Zone balancing, Kanoj Sarcar, SGI, Jan 2000
> + *  Per cpu hot/cold page lists, bulk allocation, Martin J. Bligh, Sept 2002
> + *	(lots of bits borrowed from Ingo Molnar & Andrew Morton)
> + *  Arch-independant zone size and hole calculation, Mel Gorman, IBM, Apr 2006
> + *	(lots of bits taken from architecture code)
> + */

Maybe drop the duplicated changelog? (just retain copyrights I guess)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
