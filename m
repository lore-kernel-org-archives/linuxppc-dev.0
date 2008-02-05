Return-Path: <mel@csn.ul.ie>
Received: from gir.skynet.ie (gir.skynet.ie [193.1.99.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1B86CDDE18
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 21:23:55 +1100 (EST)
Date: Tue, 5 Feb 2008 10:23:48 +0000
From: Mel Gorman <mel@csn.ul.ie>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Commit for mm/page_alloc.c breaks boot process on my machine
Message-ID: <20080205102347.GA11949@csn.ul.ie>
References: <20080201184254.174020@gmx.net> <20080201191119.GI18688@csn.ul.ie>
	<20080201200518.174050@gmx.net> <20080201202518.GJ18688@csn.ul.ie>
	<20080201210656.174030@gmx.net> <20080204104232.GB29484@csn.ul.ie>
	<1202169686.7079.17.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1202169686.7079.17.camel@pasglop>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On (05/02/08 11:01), Benjamin Herrenschmidt didst pronounce:
> 
> > 
> > It's a virtual address so it depends on the value of CONFIG_KERNEL_START
> > as to whether this is a user program address or not.
> 
> Shouldn't it be PAGE_OFFSET ? I mean, CONFIG_KERNEL_START should work
> on powerpc, but still...
> 

mel@arnold:~/git/linux-2.6$ grep PAGE_OFFSET include/asm-ppc/page.h
#define PAGE_OFFSET     CONFIG_KERNEL_START

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
