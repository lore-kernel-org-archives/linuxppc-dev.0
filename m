Return-Path: <wli@movementarian.org>
Received: from movementarian.org (movementarian.org [79.99.65.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A3E89DDEF0
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2009 17:57:07 +1100 (EST)
Date: Wed, 4 Feb 2009 01:17:47 -0500
From: wli@movementarian.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: FW: [PATCH] powerpc/mm: Export HPAGE_SHIFT
Message-ID: <20090204061747.GB10229@movementarian.org>
References: <20090203164930.GA10101@mtls03>
	<1233712248.16867.131.camel@pasglop>
	<20090203211329.d6190a08.akpm@linux-foundation.org>
	<200902041631.39784.nickpiggin@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200902041631.39784.nickpiggin@yahoo.com.au>
Cc: Eli Cohen <eli@mellanox.co.il>, Roland Dreier <rdreier@cisco.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 04 Feb 2009 12:50:48 +1100 Benjamin Herrenschmidt 
>>> Do the generic hugetlbfs code provides such an API ? If not, we may need
>>> to add one.

On Wednesday 04 February 2009 16:13:29 Andrew Morton wrote:
>> I think it's something like
>> 	huge_page_size(page_hstate(page))

On Wed, Feb 04, 2009 at 04:31:38PM +1100, Nick Piggin wrote:
> That would work if you have a page, yes. If you want to query which hugepage
> sizes are available, then you probably want for_each_hstate() (which is only
> within mm/hugetlb.c at the moment, but I have no objections to exporting it
> and symbols it requires).

Exciting things have happened in mm/hugetlb.c while I was out sick.
I've got quite some catching up to do.


-- wli
