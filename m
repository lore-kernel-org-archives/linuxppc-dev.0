Return-Path: <mel@skynet.ie>
Received: from holly.csn.ul.ie (holly.csn.ul.ie [193.1.99.76])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2837167A3B
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Apr 2006 09:50:43 +1000 (EST)
Date: Sat, 15 Apr 2006 00:50:37 +0100 (IST)
From: Mel Gorman <mel@skynet.ie>
To: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: [PATCH 0/7] [RFC] Sizing zones and holes in an architecture
	independent manner V2
In-Reply-To: <200604150917.10596.ncunningham@cyclades.com>
Message-ID: <Pine.LNX.4.64.0604150033230.22940@skynet.skynet.ie>
References: <20060412232036.18862.84118.sendpatchset@skynet>
	<200604150917.10596.ncunningham@cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: davej@codemonkey.org.uk, tony.luck@intel.com,
	Linux Memory Management List <linux-mm@kvack.org>, ak@suse.de,
	bob.picco@hp.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 15 Apr 2006, Nigel Cunningham wrote:

> It looks to me like this code could be used by the software suspend code in
> our determinations of what pages to save

Potentially yes. Currently, the node map and related functions are marked 
__init so they become unavailable but that is not set in stone.

>, particularly in the context of
> memory hotplug support.

Right now during memory hot-add, the memory is not registered with 
add_active_range(), but it would be straight-forward to add the call to 
add_memory() of each architecture that supported hotplug for example.

> Just some food for thought at the moment; I'll see if
> I can come up with a patch when I have some time, but it might help justify
> getting this merged.
>

Thanks

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
