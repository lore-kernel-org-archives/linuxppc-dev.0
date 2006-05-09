Return-Path: <nickpiggin@yahoo.com.au>
Received: from smtp101.mail.mud.yahoo.com (smtp101.mail.mud.yahoo.com
	[209.191.85.211]) by ozlabs.org (Postfix) with SMTP id 73416679E0
	for <linuxppc-dev@ozlabs.org>; Tue,  9 May 2006 11:47:40 +1000 (EST)
Message-ID: <445FF4B3.7020101@yahoo.com.au>
Date: Tue, 09 May 2006 11:47:31 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH 6/6] Break out memory initialisation code from page_alloc.c
	to mem_init.c
References: <20060508141030.26912.93090.sendpatchset@skynet>
	<20060508141231.26912.52976.sendpatchset@skynet>
In-Reply-To: <20060508141231.26912.52976.sendpatchset@skynet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: akpm@osdl.org, davej@codemonkey.org.uk, tony.luck@intel.com,
	linux-mm@kvack.org, ak@suse.de, bob.picco@hp.com,
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

>page_alloc.c contains a large amount of memory initialisation code. This patch
>breaks out the initialisation code to a separate file to make page_alloc.c
>a bit easier to read.
>

I realise this is at the wrong end of your queue, but if you _can_ easily
break it out and submit it first, it would be a nice cleanup and would help
shrink your main patchset.

Also, we're recently having some problems with architectures not aligning
zones correctly. Would it make sense to add these sorts of sanity checks,
and possibly forcing alignment corrections into your generic code?

Nick
--

Send instant messages to your online friends http://au.messenger.yahoo.com 
