Return-Path: <sachinp@in.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [59.145.155.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp09.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 403FFDDE0D
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 22:48:20 +1100 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp09.in.ibm.com (8.13.1/8.13.1) with ESMTP id n31BJ3N6021173
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Apr 2009 16:49:03 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n31BmONx2678824
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Apr 2009 17:18:24 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.13.1/8.13.3) with ESMTP id n31BmE5o010340
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Apr 2009 22:48:14 +1100
Message-ID: <49D3547E.8030200@in.ibm.com>
Date: Wed, 01 Apr 2009 17:18:14 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [ppc64] 2.6.29-git7 : offlining a cpu causes an exception
References: <49D1E21E.3090505@in.ibm.com> <1238539469.17330.70.camel@pasglop>
	<49D30C48.4090902@in.ibm.com>
In-Reply-To: <49D30C48.4090902@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sachin Sant wrote:
> Benjamin Herrenschmidt wrote:
>> On Tue, 2009-03-31 at 14:57 +0530, Sachin Sant wrote:
>>  
>>> While executing CPU HotPlug[1] tests i observed that during
>>> every cpu offline process an exception is thrown.
>>>     
>>
>> Looks like a BUG_ON() to me... can you look at what other
>> messages just before that ?  
>
Ben, seems like the following patch is causing the cpu hotplug
test failure. 

[PATCH 6/6] powerpc/mm: Introduce early_init_mmu() on 64-bit

http://ozlabs.org/pipermail/linuxppc-dev/2009-March/069613.html

If i back out this patch, i am able to offline/online cpu's
without any issue.

Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
