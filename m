Return-Path: <tony.luck@intel.com>
Received: from orsmga101-1.jf.intel.com (mga02.intel.com [134.134.136.20])
	by ozlabs.org (Postfix) with ESMTP id E935967B4F
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 08:30:27 +1000 (EST)
Date: Tue, 11 Apr 2006 15:20:29 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH 0/6] [RFC] Sizing zones and holes in an architecture
	independent manner
Message-ID: <20060411222029.GA7743@agluck-lia64.sc.intel.com>
References: <20060411103946.18153.83059.sendpatchset@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060411103946.18153.83059.sendpatchset@skynet>
Cc: linuxppc-dev@ozlabs.org, ak@suse.de, linux-kernel@vger.kernel.org,
	davej@codemonkey.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 11, 2006 at 11:39:46AM +0100, Mel Gorman wrote:

> The patches have only been *compile tested* for ia64 with a flatmem
> configuration. At attempt was made to boot test on an ancient RS/6000
> but the vanilla kernel does not boot so I have to investigate there.

The good news: Compilation is clean on the ia64 config variants that
I usually build (all 10 of them).

The bad (or at least consistent) news: It doesn't boot on an Intel
Tiger either (oops at kmem_cache_alloc+0x41).

-Tony
