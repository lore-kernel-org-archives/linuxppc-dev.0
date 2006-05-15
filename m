Return-Path: <nickpiggin@yahoo.com.au>
Received: from smtp109.mail.mud.yahoo.com (smtp109.mail.mud.yahoo.com
	[209.191.85.219]) by ozlabs.org (Postfix) with SMTP id 73E28679E7
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 20:00:15 +1000 (EST)
Message-ID: <44685123.7040501@yahoo.com.au>
Date: Mon, 15 May 2006 20:00:03 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
To: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH 5/6] Have ia64 use add_active_range() and
	free_area_init_nodes
References: <20060508141030.26912.93090.sendpatchset@skynet>	<20060508141211.26912.48278.sendpatchset@skynet>
	<20060514203158.216a966e.akpm@osdl.org>
	<44683A09.2060404@shadowen.org>
In-Reply-To: <44683A09.2060404@shadowen.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, davej@codemonkey.org.uk, tony.luck@intel.com,
	linuxppc-dev@ozlabs.org, Mel Gorman <mel@csn.ul.ie>,
	linux-kernel@vger.kernel.org, bob.picco@hp.com, ak@suse.de,
	linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andy Whitcroft wrote:

> Interesting.  You are correct there was no config component, at the time
> I didn't have direct evidence that any architecture needed it, only that
> we had an unchecked requirement on zones, a requirement that had only
> recently arrived with the changes to free buddy detection.  I note that

Recently arrived? Over a year ago with the no-buddy-bitmap patches,
right? Just checking because I that's what I'm assuming broke it...

> MAX_ORDER is 17 for ia64 so that probabally accounts for the
> missalignment.  It is clear that the reporting is slightly over-zelous
> as I am reporting zero-sized zones.  I'll get that fixed and patch to
> you.  I'll also have a look at the patch as added to -mm and try and get
> the rest of the spelling sorted :-/.
> 
> I'll go see if we currently have a machine to test this config on.


-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
