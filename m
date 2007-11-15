Return-Path: <mel@skynet.ie>
Received: from gir.skynet.ie (gir.skynet.ie [193.1.99.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 07640DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 21:14:03 +1100 (EST)
Date: Thu, 15 Nov 2007 10:13:58 +0000
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Do not depend on MAX_ORDER when grouping pages by mobility
Message-ID: <20071115101358.GB5128@skynet.ie>
References: <20071112132108.7c98f011.sfr@canb.auug.org.au>
	<20071112155452.GB6653@skynet.ie>
	<20071113114401.73d81ce2.sfr@canb.auug.org.au>
	<20071114181044.GB773@skynet.ie>
	<20071115141740.d22acb0e.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20071115141740.d22acb0e.sfr@canb.auug.org.au>
From: mel@skynet.ie (Mel Gorman)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On (15/11/07 14:17), Stephen Rothwell didst pronounce:
> Hi Mel,
> 
> On Wed, 14 Nov 2007 18:10:45 +0000 mel@skynet.ie (Mel Gorman) wrote:
> >
> > libhugetlbfs test suite and boot test on iSeries is sufficient in this
> > case. However, the version I sent would break on IA-64 due to the lack of
> > a definition for HPAGE_SHIFT when CONFIG_HUGETLB_PAGE is not set. Can you
> > confirm this patch still fixes the problem please? If it does, I'll send
> > it to Andrew as a fix for 2.6.24. Whether iSeries is legacy or not, this is
> > breakage and should be fixed.
> 
> The new patch works fine.  I reran the libhugetlbfs tests on a Power5+
> machine and the ppc64_defconfig boots on legacy iSeries.
> 

Thanks a million for reporting and testing. I've pushed the patch to Andrew.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
