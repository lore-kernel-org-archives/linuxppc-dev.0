Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t81sH2tfXzDt53
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 19:45:55 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA28hpIx011715
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 04:45:53 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26fcmxrud9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Nov 2016 04:45:53 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 2 Nov 2016 04:45:52 -0400
Date: Wed, 2 Nov 2016 14:15:48 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/64s: relocation, register save fixes for system
 reset interrupt
Reply-To: ego@linux.vnet.ibm.com
References: <20161013021714.6624-1-npiggin@gmail.com>
 <79d229aa-2b4e-67b7-157b-b839bc390cbf@linux.vnet.ibm.com>
 <20161102175701.2ae8d1d3@roar.ozlabs.ibm.com>
 <20161102082433.GA17365@in.ibm.com>
 <20161102193624.7f0cbfee@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161102193624.7f0cbfee@roar.ozlabs.ibm.com>
Message-Id: <20161102084548.GD17909@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nick,

On Wed, Nov 02, 2016 at 07:36:24PM +1100, Nicholas Piggin wrote:
> 
> Okay, I'll work with that. What's the best way to make a P8 do
> winkle sleeps?

>From the userspace, offlining the CPUs of the core will put them to
winkle.

> 
> Thanks,
> Nick
> 
--
Thanks and Regards
gautham.
