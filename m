Return-Path: <ak@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4578E679E9
	for <linuxppc-dev@ozlabs.org>; Sun, 21 May 2006 07:27:45 +1000 (EST)
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 4/6] Have x86_64 use add_active_range() and
	free_area_init_nodes
Date: Sat, 20 May 2006 23:27:18 +0200
References: <20060508141030.26912.93090.sendpatchset@skynet>
	<20060508141151.26912.15976.sendpatchset@skynet>
	<20060520135922.129a481d.akpm@osdl.org>
In-Reply-To: <20060520135922.129a481d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605202327.19606.ak@suse.de>
Cc: davej@codemonkey.org.uk, tony.luck@intel.com, linux-mm@kvack.org,
	Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
	bob.picco@hp.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Anyway.  From the implementation I can see what the code is doing.  But I
> see no description of what it is _supposed_ to be doing.  (The process of
> finding differences between these two things is known as "debugging").  I
> could kludge things by setting MAX_ACTIVE_REGIONS to 1000000, but enough. 
> I look forward to the next version ;)

Or we could just keep the working old code.

Can somebody remind me what this patch kit was supposed to fix or improve again? 

-Andi
