Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id ABEFE67B43
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 09:43:56 +1000 (EST)
Date: Tue, 6 Jun 2006 16:43:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH 0/5] Sizing zones and holes in an architecture
	independent manner V7
Message-Id: <20060606164311.27d4af98.akpm@osdl.org>
In-Reply-To: <20060606134710.21419.48239.sendpatchset@skynet.skynet.ie>
References: <20060606134710.21419.48239.sendpatchset@skynet.skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: davej@codemonkey.org.uk, tony.luck@intel.com, linux-mm@kvack.org,
	mel@csn.ul.ie, ak@suse.de, bob.picco@hp.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue,  6 Jun 2006 14:47:10 +0100 (IST)
Mel Gorman <mel@csn.ul.ie> wrote:

> This is V7 of the patchset to size zones and memory holes in an
> architecture-independent manner.

I hope this won't deprive me of my 4 kbyte highmem zone.

I won't merge these patches for rc6-mm1 - we already have a few problems in
this area which I don't think anyone understands yet.
