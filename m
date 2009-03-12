Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 010C0DE145
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 23:40:13 +1100 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp08.au.ibm.com (8.13.1/8.13.1) with ESMTP id n2CCeDmt012421
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 23:40:13 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n2CCeUwR729088
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 23:40:30 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n2CCeCeI003646
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 23:40:12 +1100
Message-ID: <49B902AA.20306@in.ibm.com>
Date: Thu, 12 Mar 2009 18:10:10 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: 2.6.29-rc7-git2 : crash in kmem_list3_init()
References: <49B5448B.6030205@in.ibm.com> <49B60371.7050508@in.ibm.com>
	<20090310134610.GB13020@csn.ul.ie> <49B677AB.1010006@in.ibm.com>
In-Reply-To: <49B677AB.1010006@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, cl@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sachin P. Sant wrote:
> Mel Gorman wrote:
>>
>> Well, the machine must have started with some kernel. What mainline
>> version does that correspond to and can you bisect it?
>>   
> The last booted kernel was a 2.6.25 based kernel. I am trying to find out
> the last good kernel.org kernel. I should have that information by 
> tomorrow.
Sorry it took some time to get to this.

After lots of build, i found that the problem depends on PAGE_SIZE.
With 4K Page Size i was able to boot 2.6.29-rc7-git2 kernel on this
box. But with 64K page size the machine panics.

Is there any other information i could provide to find a solution
for this issue ?


Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
