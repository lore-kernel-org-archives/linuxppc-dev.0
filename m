Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 28876DDF65
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 16:15:10 +1000 (EST)
Date: Wed, 30 Jul 2008 23:14:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [RFC] [PATCH 0/5 V2] Huge page backed user-space stacks
Message-Id: <20080730231428.a7bdcfa7.akpm@linux-foundation.org>
In-Reply-To: <200807311604.14349.nickpiggin@yahoo.com.au>
References: <cover.1216928613.git.ebmunson@us.ibm.com>
	<20080730172317.GA14138@csn.ul.ie>
	<20080730103407.b110afc2.akpm@linux-foundation.org>
	<200807311604.14349.nickpiggin@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-mm@kvack.org, Mel Gorman <mel@csn.ul.ie>,
	libhugetlbfs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Eric Munson <ebmunson@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 31 Jul 2008 16:04:14 +1000 Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> > Do we expect that this change will be replicated in other
> > memory-intensive apps?  (I do).
> 
> Such as what? It would be nice to see some numbers with some HPC or java
> or DBMS workload using this. Not that I dispute it will help some cases,
> but 10% (or 20% for ppc) I guess is getting toward the best case, short
> of a specifically written TLB thrasher.

I didn't realise the STREAM is using vast amounts of automatic memory. 
I'd assumed that it was using sane amounts of stack, but the stack TLB
slots were getting zapped by all the heap-memory activity.  Oh well.

I guess that effect is still there, but smaller.

I agree that few real-world apps are likely to see gains of this
order.  More benchmarks, please :)
