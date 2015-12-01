Return-Path: <vipin@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 29A831A0707
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 20:12:00 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vipin@linux.vnet.ibm.com>;
 Tue, 1 Dec 2015 19:12:00 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id EED902BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 20:11:55 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB19BlVD52494448
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 20:11:55 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB19BNVL006763
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 20:11:23 +1100
Subject: Re: [PATCH v5] powerpc/pseries: Limit EPOW reset event warnings
To: Michael Ellerman <mpe@ellerman.id.au>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1447836157-19599-1-git-send-email-vipin@linux.vnet.ibm.com>
 <5656CEC9.4070000@linux.vnet.ibm.com> <565C3A83.8080504@linux.vnet.ibm.com>
 <1448941585.9027.4.camel@ellerman.id.au>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
From: Vipin K Parashar <vipin@linux.vnet.ibm.com>
Message-ID: <565D6428.9080602@linux.vnet.ibm.com>
Date: Tue, 1 Dec 2015 14:41:04 +0530
MIME-Version: 1.0
In-Reply-To: <1448941585.9027.4.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 01 December 2015 09:16 AM, Michael Ellerman wrote:
> On Mon, 2015-11-30 at 17:31 +0530, Vipin K Parashar wrote:
>> On Thursday 26 November 2015 02:50 PM, Vasant Hegde wrote:
>>> On 11/18/2015 02:12 PM, Vipin K Parashar wrote:
>>>> Kernel prints respective warnings about various EPOW events for
>>>> user information/action after parsing EPOW interrupts. At times
>>>> below EPOW reset event warning is seen to be flooding kernel log
>>>> over a period of time.
>>>>
>>>> May 25 03:46:34 alp kernel: Non critical power or cooling issue cleared
>>>> May 25 03:46:52 alp kernel: Non critical power or cooling issue cleared
>>>> May 25 03:53:48 alp kernel: Non critical power or cooling issue cleared
>>>> May 25 03:55:46 alp kernel: Non critical power or cooling issue cleared
>>>> May 25 03:56:34 alp kernel: Non critical power or cooling issue cleared
>>>> May 25 03:59:04 alp kernel: Non critical power or cooling issue cleared
>>>> May 25 04:02:01 alp kernel: Non critical power or cooling issue cleared
>>>>
>>> @Michael,
>>>    I think above log is raising some concern. We have been asked by multiple
>>> people on this. Hence I think we should avoid these duplicate messages.
>> Hi Michael,
>>            Please do let know if you have some suggestions with this patch.
>
> It seems OK to me. I actually had it in my testing tree and was about to merge
> it when Vasant replied with comments.
>
> So if you two can agree on a final patch I'll merge it.

Thanks Michael, I will send out next revision for this addressing 
Vasant's comment.

>
> cheers
>
