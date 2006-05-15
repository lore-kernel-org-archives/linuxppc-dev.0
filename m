Return-Path: <apw@shadowen.org>
Received: from hellhawk.shadowen.org (hellhawk.shadowen.org [80.68.90.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hellhawk.shadowen.org",
	Issuer "hellhawk.shadowen.org" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A4A4D679F6
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 20:21:01 +1000 (EST)
Message-ID: <446855AF.1090100@shadowen.org>
Date: Mon, 15 May 2006 11:19:27 +0100
From: Andy Whitcroft <apw@shadowen.org>
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH 5/6] Have ia64 use add_active_range() and
	free_area_init_nodes
References: <20060508141030.26912.93090.sendpatchset@skynet>	<20060508141211.26912.48278.sendpatchset@skynet>
	<20060514203158.216a966e.akpm@osdl.org>
	<44683A09.2060404@shadowen.org> <44685123.7040501@yahoo.com.au>
In-Reply-To: <44685123.7040501@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1
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

Nick Piggin wrote:
> Andy Whitcroft wrote:
> 
>> Interesting.  You are correct there was no config component, at the time
>> I didn't have direct evidence that any architecture needed it, only that
>> we had an unchecked requirement on zones, a requirement that had only
>> recently arrived with the changes to free buddy detection.  I note that
> 
> 
> Recently arrived? Over a year ago with the no-buddy-bitmap patches,
> right? Just checking because I that's what I'm assuming broke it...

Yep, sorry I forget I was out of the game for 6 months!  And yes that
was when the requirements were altered.

-apw
