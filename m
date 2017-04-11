Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2N3X59tszDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 20:05:44 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Sachin Sant <sachinp@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: kselftest:lost_exception_test failure with 4.11.0-rc5
In-Reply-To: <6ffc8fd9-63f9-b1b0-864c-3ab546cb1d5f@linux.vnet.ibm.com>
References: <2868072E-9D12-4BE0-94F6-FE9C33A3766F@linux.vnet.ibm.com>
 <87r314gzt1.fsf@concordia.ellerman.id.au>
 <6ffc8fd9-63f9-b1b0-864c-3ab546cb1d5f@linux.vnet.ibm.com>
Date: Tue, 11 Apr 2017 20:05:42 +1000
Message-ID: <87y3v7uumh.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:

> On Friday 07 April 2017 06:06 PM, Michael Ellerman wrote:
>> Sachin Sant <sachinp@linux.vnet.ibm.com> writes:
>>
>>> I have run into few instances where the lost_exception_test from
>>> powerpc kselftest fails with SIGABRT. Following o/p is against
>>> 4.11.0-rc5. The failure is intermittent.
>> What hardware are you on?
>>
>> How long does it take to run when it fails? I assume ~2 minutes?
>
> Started a run in power8 host (habanero) and it is more than 24hrs and
> havent failed yet. So this should be guest/VM scenario then?

Aha good point. I never tested this much (at all?) on VMs because it was
about verifying a workaround for a hardware bug.

So does it happen on both KVM and PowerVM or just one or the other?

cheers
