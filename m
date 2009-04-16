Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A2607DE223
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 15:37:03 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id n3G5aRbn017389
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 15:36:27 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n3G5atW1287046
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 15:37:00 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n3G5as6H021090
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 15:36:54 +1000
Message-ID: <49E6C3F4.4080801@in.ibm.com>
Date: Thu, 16 Apr 2009 11:06:52 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [ppc64] 2.6.29-git7 : offlining a cpu causes an exception
References: <49D1E21E.3090505@in.ibm.com> <1238539469.17330.70.camel@pasglop>
	<49D30C48.4090902@in.ibm.com> <49D3547E.8030200@in.ibm.com>
In-Reply-To: <49D3547E.8030200@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sachin Sant wrote:
> Sachin Sant wrote:
>> Benjamin Herrenschmidt wrote:
>>> On Tue, 2009-03-31 at 14:57 +0530, Sachin Sant wrote:
>>>  
>>>> While executing CPU HotPlug[1] tests i observed that during
>>>> every cpu offline process an exception is thrown.
>>>>     
>>>
>>> Looks like a BUG_ON() to me... can you look at what other
>>> messages just before that ?  
>>
> Ben, seems like the following patch is causing the cpu hotplug
> test failure.
> [PATCH 6/6] powerpc/mm: Introduce early_init_mmu() on 64-bit
>
> http://ozlabs.org/pipermail/linuxppc-dev/2009-March/069613.html
>
> If i back out this patch, i am able to offline/online cpu's
> without any issue.
I can recreate this problem with 2.6.30-rc2-git1 as well. Same BUG_ON while
running cpu hotplug tests.

Let me know if there is any thing i can help to find a fix for this.

Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
