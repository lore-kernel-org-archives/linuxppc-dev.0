Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xc46n34G9zDqXk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 18:51:45 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7M8pg5H068796
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 04:51:43 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cgg3snm6m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 04:51:43 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Tue, 22 Aug 2017 18:51:40 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7M8pbVR34472034
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 18:51:37 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7M8pZWD029659
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 18:51:37 +1000
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: David Miller <davem@davemloft.net>, npiggin@gmail.com,
 paulmck@linux.vnet.ibm.com, mpe@ellerman.id.au, dzickus@redhat.com,
 sfr@canb.auug.org.au, linuxarm@huawei.com, tglx@linutronix.de,
 sparclinux@vger.kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 john.stultz@linaro.org
Date: Tue, 22 Aug 2017 14:21:32 +0530
In-Reply-To: <20170822084911.00000c23@huawei.com>
References: <20170821160605.5b1cc019@roar.ozlabs.ibm.com>
 <20170821111833.00006753@huawei.com>
 <20170822001928.74f01322@roar.ozlabs.ibm.com>
 <20170821.135504.1392954698746959868.davem@davemloft.net>
 <20170822084911.00000c23@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1503391892.3629.28.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-08-22 at 08:49 +0100, Jonathan Cameron wrote:
> On Mon, 21 Aug 2017 13:55:04 -0700
> David Miller <davem@davemloft.net> wrote:
> 
> > From: Nicholas Piggin <npiggin@gmail.com>
> > Date: Tue, 22 Aug 2017 00:19:28 +1000
> > 
> > > Thanks here's an updated version with a couple more bugs fixed. If
> > > you could try testing, that would be much appreciated.  
> > 
> > I'm not getting RCU stalls on sparc64 any longer with this patch.
> > 
> > I'm really happy you guys were able to figure out what was going
> > wrong. :-)
> > 
> > Feel free to add my Tested-by:
> > 
> 
> Like wise - 16 hours of clean run with the latest
> 
> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Thanks for all the hard work everyone put into this one, great to
> cross it off the list!
> 
> Jonathan
> 

No more RCU stalls on PowerPC, system is clean when idle or with some
test runs.

Thank you all for your time and efforts in fixing this.

Reported-and-Tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
