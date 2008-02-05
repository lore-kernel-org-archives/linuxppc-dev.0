Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F268DDDF53
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 07:50:44 +1100 (EST)
Subject: Re: Commit for mm/page_alloc.c breaks boot process on my machine
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mel Gorman <mel@csn.ul.ie>
In-Reply-To: <20080205102347.GA11949@csn.ul.ie>
References: <20080201184254.174020@gmx.net>
	<20080201191119.GI18688@csn.ul.ie> <20080201200518.174050@gmx.net>
	<20080201202518.GJ18688@csn.ul.ie> <20080201210656.174030@gmx.net>
	<20080204104232.GB29484@csn.ul.ie> <1202169686.7079.17.camel@pasglop>
	<20080205102347.GA11949@csn.ul.ie>
Content-Type: text/plain
Date: Wed, 06 Feb 2008 07:50:20 +1100
Message-Id: <1202244620.7079.70.camel@pasglop>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-02-05 at 10:23 +0000, Mel Gorman wrote:
> On (05/02/08 11:01), Benjamin Herrenschmidt didst pronounce:
> > 
> > > 
> > > It's a virtual address so it depends on the value of CONFIG_KERNEL_START
> > > as to whether this is a user program address or not.
> > 
> > Shouldn't it be PAGE_OFFSET ? I mean, CONFIG_KERNEL_START should work
> > on powerpc, but still...
> > 
> 
> mel@arnold:~/git/linux-2.6$ grep PAGE_OFFSET include/asm-ppc/page.h
> #define PAGE_OFFSET     CONFIG_KERNEL_START

On powerpc sure.... but it's still dodgy I think.

Ben.
