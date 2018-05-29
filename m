Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wDcr2zgCzDqGD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 23:11:07 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4TD8DP2138863
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 09:11:05 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j970nhmva-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 09:11:04 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Tue, 29 May 2018 07:11:04 -0600
Subject: Re: [next-20180517][ppc] watchdog: CPU 88 self-detected hard LOCKUP
 @ update_cfs_group+0x30/0x150
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: sachinp <sachinp@linux.vnet.ibm.com>, Stephen Rothwell
 <sfr@canb.auug.org.au>, linux-kernel <linux-kernel@vger.kernel.org>,
 linux-next <linux-next@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 29 May 2018 18:39:40 +0530
In-Reply-To: <20180521165056.5f3dceeb@roar.ozlabs.ibm.com>
References: <1526883300.19317.18.camel@abdul>
 <20180521165056.5f3dceeb@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1527599380.3777.3.camel@abdul>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-05-21 at 16:50 +1000, Nicholas Piggin wrote:
> Ah, it's POWER8.
> 
> I'm betting we have a bug with nohz timer offloading somewhere.
> 
> I *think* we may have seen similar on P9 as well, but that may be
> related to problems with stop states.
> 
> Can you reproduce it easily? I'm thinking maybe adding some
> tracepoints that track decrementer settings and interrupts, and
> nohz offload activity might show something up.

Yes, the problem is reproducible consistently on our CI setup and today
It triggered on 4.17.0-rc6 (mainline) too.

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
