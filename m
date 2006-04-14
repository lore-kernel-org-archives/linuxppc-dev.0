Return-Path: <tony.luck@intel.com>
Received: from orsmga101-1.jf.intel.com (mga02.intel.com [134.134.136.20])
	by ozlabs.org (Postfix) with ESMTP id A1B79679EF
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Apr 2006 06:53:50 +1000 (EST)
Date: Fri, 14 Apr 2006 13:53:45 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH 0/7] [RFC] Sizing zones and holes in an architecture
	independent manner V2
Message-ID: <20060414205345.GA1258@agluck-lia64.sc.intel.com>
References: <20060412232036.18862.84118.sendpatchset@skynet>
	<20060413095207.GA4047@skynet.ie>
	<20060413171942.GA15047@agluck-lia64.sc.intel.com>
	<20060413173008.GA19402@skynet.ie>
	<20060413174720.GA15183@agluck-lia64.sc.intel.com>
	<20060413191402.GA20606@skynet.ie>
	<20060413215358.GA15957@agluck-lia64.sc.intel.com>
	<20060414131235.GA19064@skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060414131235.GA19064@skynet.ie>
Cc: davej@codemonkey.org.uk, linuxppc-dev@ozlabs.org, ak@suse.de,
	bob.picco@hp.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 14, 2006 at 02:12:35PM +0100, Mel Gorman wrote:
> That appears fine, but I call add_active_range() after a GRANULEROUNDUP and
> GRANULEROUNDDOWN has taken place so that might be the problem, especially as
> all those ranges are aligned on a 16MiB boundary. The following patch calls
> add_active_range() before the rounding takes place. Can you try it out please?

That's good.  Now I see identical output before/after your patch for
the generic (DISCONTIG=y) kernel:

On node 0 totalpages: 259873
  DMA zone: 128931 pages, LIFO batch:7
  Normal zone: 130942 pages, LIFO batch:7

-Tony
