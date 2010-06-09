Return-Path: <roland@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 3984DB7D59
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Jun 2010 08:33:04 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH v21 011/100] eclone (11/11): Document sys_eclone
In-Reply-To: Sukadev Bhattiprolu's message of  Wednesday,
	9 June 2010 11:14:31 -0700 <20100609181431.GB1211@us.ibm.com>
References: <AANLkTimDfbJkAuoK1-asvk8Ub9C9QBkK5RkzLR3ilJUY@mail.gmail.com>
	<20100601193230.GA17579@us.ibm.com>
	<AANLkTinxCKl7RVe62UhIpNe5EriCufkgaih2D2mLLmC4@mail.gmail.com>
	<20100602013839.GB17579@us.ibm.com>
	<AANLkTinFGblE4fW35O0LchJZ22tz_5-qervpGC_lpUj_@mail.gmail.com>
	<20100609181431.GB1211@us.ibm.com>
Message-Id: <20100609223249.AC8204B2CC@magilla.sf.frob.com>
Date: Wed,  9 Jun 2010 15:32:49 -0700 (PDT)
Cc: randy.dunlap@oracle.com, arnd@arndb.de, Albert Cahalan <acahalan@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, hpa@zytor.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Peter, Arnd, Roland - do you have any concerns with requiring all
> architectures to specify the stack to eclone() as [base, offset]

I can't see why that would be a problem.  
It's consistent with the sigaltstack interface we already have.


Thanks,
Roland
