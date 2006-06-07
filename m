Return-Path: <ak@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 806D9679FB
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 19:47:12 +1000 (EST)
From: Andi Kleen <ak@suse.de>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH 0/5] Sizing zones and holes in an architecture independent
	manner V7
Date: Wed, 7 Jun 2006 11:45:04 +0200
References: <20060606134710.21419.48239.sendpatchset@skynet.skynet.ie>
	<20060606164311.27d4af98.akpm@osdl.org>
	<Pine.LNX.4.64.0606071030100.20653@skynet.skynet.ie>
In-Reply-To: <Pine.LNX.4.64.0606071030100.20653@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200606071145.04938.ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, davej@codemonkey.org.uk, tony.luck@intel.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	bob.picco@hp.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Spanned pages and holes will be different on 
> x86_64 because I don't account the kernel image and memmap as holes. 

That's a significant inaccuracy and may give worse VM results.

-Andi
