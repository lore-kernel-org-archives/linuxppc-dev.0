Return-Path: <ak@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5B1D9679E1
	for <linuxppc-dev@ozlabs.org>; Sun, 21 May 2006 08:18:16 +1000 (EST)
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 4/6] Have x86_64 use add_active_range() and
	free_area_init_nodes
Date: Sun, 21 May 2006 00:17:59 +0200
References: <20060508141030.26912.93090.sendpatchset@skynet>
	<200605202327.19606.ak@suse.de>
	<20060520144043.22f993b1.akpm@osdl.org>
In-Reply-To: <20060520144043.22f993b1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605210017.59984.ak@suse.de>
Cc: davej@codemonkey.org.uk, tony.luck@intel.com, linux-mm@kvack.org,
	mel@csn.ul.ie, linux-kernel@vger.kernel.org, bob.picco@hp.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 
> Well, it creates arch-neutral common code, teaches various architectures
> use it.  It's the sort of thing we do all the time.
> 
> These things are opportunities to eliminate crufty arch code which few
> people understand and replace them with new, clean common code which lots
> of people understand.  That's not a bad thing to be doing.

I'm not fundamentally against that, but so far it seems to just generate lots of 
new bugs?  I'm not sure it's really worth the pain.

-Andi
