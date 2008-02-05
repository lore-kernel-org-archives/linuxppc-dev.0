Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 80D8CDDE20
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 11:02:16 +1100 (EST)
Subject: Re: Commit for mm/page_alloc.c breaks boot process on my machine
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mel Gorman <mel@csn.ul.ie>
In-Reply-To: <20080204104232.GB29484@csn.ul.ie>
References: <20080201184254.174020@gmx.net>
	<20080201191119.GI18688@csn.ul.ie> <20080201200518.174050@gmx.net>
	<20080201202518.GJ18688@csn.ul.ie> <20080201210656.174030@gmx.net>
	<20080204104232.GB29484@csn.ul.ie>
Content-Type: text/plain
Date: Tue, 05 Feb 2008 11:01:26 +1100
Message-Id: <1202169686.7079.17.camel@pasglop>
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


> 
> It's a virtual address so it depends on the value of CONFIG_KERNEL_START
> as to whether this is a user program address or not.

Shouldn't it be PAGE_OFFSET ? I mean, CONFIG_KERNEL_START should work
on powerpc, but still...

Ben.
