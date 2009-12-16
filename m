Return-Path: <sachinp@in.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp06.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 412EAB6F1B
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 17:54:15 +1100 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp06.in.ibm.com (8.14.3/8.13.1) with ESMTP id nBG6sCkH032429
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 12:24:12 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBG6sCuC2871524
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 12:24:12 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nBG6sCGo010402
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 17:54:12 +1100
Message-ID: <4B288413.2070704@in.ibm.com>
Date: Wed, 16 Dec 2009 12:24:11 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Xiaotian Feng <xtfeng@gmail.com>
Subject: Re: [Next] CPU Hotplug test failures on powerpc
References: <4B2224C7.1020908@in.ibm.com>
	<7b6bb4a50912152225p4f5dde13re83c439407c16eaf@mail.gmail.com>
	<4B288131.2050306@in.ibm.com>
	<7b6bb4a50912152245v61a7f1ebgb41f4857134f3476@mail.gmail.com>
In-Reply-To: <7b6bb4a50912152245v61a7f1ebgb41f4857134f3476@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Peter Zijlstra <peterz@infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	linux-next@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Xiaotian Feng wrote:
> On Wed, Dec 16, 2009 at 2:41 PM, Sachin Sant <sachinp@in.ibm.com> wrote:
>   
>> Xiaotian Feng wrote:
>>     
>>> Does this testcase hotplug cpu 0 off?
>>>
>>>       
>> No, i don't think so. It skips cpu0 during online/offline
>> process.
>>     
>
> Then how could this happen ? Looks like cpu 0 is offline ....
> 0:mon> <4>IRQ 17 affinity broken off cpu 0
> <4>IRQ 18 affinity broken off cpu 0
> <4>IRQ 19 affinity broken off cpu 0
> <4>IRQ 264 affinity broken off cpu 0
> <4>cpu 0 (hwid 0) Ready to die...
> <7>clockevent: decrementer mult[83126e97] shift[32] cpu[0]
>   
Sorry i was looking at only one script. Looking more closely
at the test there are 6 different sub tests. The rest of the
tests do seem to hotplug CPU 0.

Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
