Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18456.60948.463017.139935@cargo.ozlabs.ibm.com>
Date: Thu, 1 May 2008 08:09:24 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] docbook: fix fatal rapidio yet again (and more to come)
In-Reply-To: <20080430121239.28492328.akpm@linux-foundation.org>
References: <Pine.LNX.4.64.0804292009000.18219@shark.he.net>
	<20080430113500.dfe21880.akpm@linux-foundation.org>
	<51A34080-7981-4958-B225-4921FC95B84A@kernel.crashing.org>
	<20080430121239.28492328.akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, rdunlap@xenotime.net,
	torvalds@linux-foundation.org, Zhang Wei <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Morton writes:

> > Odd.  I thought Paul had picked up a docbook RapidIO patch from you in  
> > the latest merge round.
> > 
> 
> Well it's more than "a" patch.  The six-week-old patch series is:
> 
> rapidio-add-memory-mapping-driver-to-rapidio.patch
> rapidio-add-rapidio-space-allocation-bitmap-arithmetic.patch
> rapidio-add-fsl-rapidio-controller-memory-ops-functions.patch
> rapidio-add-the-rapidio-master-port-maintance-and-doorbell-window-to-space-resources.patch
> rapidio-add-rapidio-proc-fs-for-memory-mapping-debugging.patch
> rapidio-add-the-memory-mapping-support-in-rionet-driver.patch
> rapidio-fix-docbook-references.patch
> rapidio-fix-kernel-doc-problems.patch

What happened is that you (Andrew) sent them on to me pretty much
unexamined.  I took a look at them and dropped one of them because it
created a new /proc file.  I asked Kumar to look at them and he had
issues with another three of the patches, and dropping those meant
that all the following ones (including the fix-kernel-doc one)
wouldn't apply, so I dropped them too.  I applied the rest and sent
them to Linus.

> (seems that I forgot to cc Jeff on the rionet change too).

Yeah.  I nearly dropped that one too.  I probably should have. :)

> Oh well.  If nobody puts their hand up in the next 24 hours or so I'll just
> send it all in to Linus.

Please don't.  At this stage I think the best thing is for Kumar to
talk to Zhang Wei (they both work for Freescale, so that should be
possible in theory :) and get him to rework the remaining patches as
required for inclusion in 2.6.27.

Paul.
