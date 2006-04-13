Return-Path: <tony.luck@intel.com>
Received: from fmsmga101-1.fm.intel.com (mga01.intel.com [192.55.52.88])
	by ozlabs.org (Postfix) with ESMTP id 26CFE67A40
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Apr 2006 03:47:25 +1000 (EST)
Date: Thu, 13 Apr 2006 10:47:20 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH 0/7] [RFC] Sizing zones and holes in an architecture
	independent manner V2
Message-ID: <20060413174720.GA15183@agluck-lia64.sc.intel.com>
References: <20060412232036.18862.84118.sendpatchset@skynet>
	<20060413095207.GA4047@skynet.ie>
	<20060413171942.GA15047@agluck-lia64.sc.intel.com>
	<20060413173008.GA19402@skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060413173008.GA19402@skynet.ie>
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

> Double counted a hole here, then went downhill. Does the following fix
> it?

Yes, that boots.  What's more the counts of pages in DMA/Normal
zone match the kernel w/o your patches too.  So for tiger_defconfig
you've now exactly matched the old behaivour.

I'll try to test generic and sparse kernels later, but I have to
look at another issue now.

-Tony
