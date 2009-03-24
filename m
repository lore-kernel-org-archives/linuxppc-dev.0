Return-Path: <BATV+6f373c4282e37a9c7400+2039+infradead.org+dwmw2@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 16A8DDDF6B
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 01:05:04 +1100 (EST)
Subject: Re: [PATCH v2] Check name property to determine partition nodes.
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Krill <ben@codiert.org>
In-Reply-To: <20090324132733.GN11318@codiert.org>
References: <20090123161805.GA2598@codiert.org>
	<1233720542.16867.187.camel@pasglop>
	<20090218074738.GC12204@codiert.org>
	<20090324132733.GN11318@codiert.org>
Content-Type: text/plain
Date: Tue, 24 Mar 2009 14:04:54 +0000
Message-Id: <1237903494.9441.1364.camel@macbook.infradead.org>
Mime-Version: 1.0
Cc: dwg@au1.ibm.com, linux-mtd@lists.infradead.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-03-24 at 14:27 +0100, Benjamin Krill wrote:
> >>On Fri, 2009-01-23 at 17:18 +0100, Benjamin Krill wrote:
> >>> SLOF has a further node which could not be evaluate
> >>> by the current routine. The current routine returns
> >>> because the node hasn't the required reg property. As
> >>> fix this patch adds a check to determine the partition
> >>> child nodes. If the node is not an partition the number
> >>> of total partitions will be decreased and loop continue
> >>> with the next nodes.
> >>
> >>Somebody on the MTD list is taking that ? David ? Or should I merge it
> >>via powerpc ?
> >
> >Could somebody merge it for the next release?
> 
> Again, new try to get it somewhere merged.

Applied; thanks.

-- 
dwmw2
