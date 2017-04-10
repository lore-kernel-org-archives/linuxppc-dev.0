Return-Path: <srs0=ctsj=3s=linux.vnet.ibm.com=sachinp@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1jL65nlFzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 18:01:02 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w1jL657vQz8syC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 18:01:02 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3w1jL616Xgz9s8W
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2017 18:01:01 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3A7mmKF019474
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2017 04:00:59 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29qykyxq35-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2017 04:00:59 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sachinp@linux.vnet.ibm.com>;
 Mon, 10 Apr 2017 13:30:56 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3A80rdC20709562
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2017 13:30:53 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3A80qN6019711
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2017 13:30:53 +0530
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: kselftest:lost_exception_test failure with 4.11.0-rc5
From: Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <87r314gzt1.fsf@concordia.ellerman.id.au>
Date: Mon, 10 Apr 2017 13:30:51 +0530
Cc: linuxppc-dev@ozlabs.org, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
References: <2868072E-9D12-4BE0-94F6-FE9C33A3766F@linux.vnet.ibm.com>
 <87r314gzt1.fsf@concordia.ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Message-Id: <246FBE89-1651-432A-9E1B-E92E4B80CB4C@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> On 07-Apr-2017, at 6:06 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> Sachin Sant <sachinp@linux.vnet.ibm.com> writes:
> 
>> I have run into few instances where the lost_exception_test from
>> powerpc kselftest fails with SIGABRT. Following o/p is against
>> 4.11.0-rc5. The failure is intermittent. 
> 
> What hardware are you on?

I have seen this problem on a POWER8 LPAR.

> 
> How long does it take to run when it fails? I assume ~2 minutes?

Yes somewhere around 2 min.


>> MMCR2 0x0000000000000000
>> EBBHR 0x0000000010003dcc
>> BESCR 0x8000000100000000 GE PMAE 
> 
> And that says we have global enable set and events enabled.
> 
> 
> So I think there is a bug here somewhere. I don't really have time to
> dig into it now, neither does Maddy I think. But we should try and get
> to it at some point.
> 

Let me know if I can help with debug.

Thanks
-Sachin


> cheers
> 
