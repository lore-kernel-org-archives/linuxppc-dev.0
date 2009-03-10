Return-Path: <sachinp@in.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [59.145.155.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp01.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1CCEFDDE0E
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 01:22:41 +1100 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp01.in.ibm.com (8.13.1/8.13.1) with ESMTP id n2AEMauN030835
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 19:52:37 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n2AEJRU63510334
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 19:49:27 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id n2AEMaPD006548
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 19:52:36 +0530
Message-ID: <49B677AB.1010006@in.ibm.com>
Date: Tue, 10 Mar 2009 19:52:35 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: 2.6.29-rc7-git2 : crash in kmem_list3_init()
References: <49B5448B.6030205@in.ibm.com> <49B60371.7050508@in.ibm.com>
	<20090310134610.GB13020@csn.ul.ie>
In-Reply-To: <20090310134610.GB13020@csn.ul.ie>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linuxppc-dev@ozlabs.org, cl@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mel Gorman wrote:
>
> Well, the machine must have started with some kernel. What mainline
> version does that correspond to and can you bisect it?
>   
The last booted kernel was a 2.6.25 based kernel. I am trying to find out
the last good kernel.org kernel. I should have that information by tomorrow.


> What is the base page size of the test kernel - 4K or 64K? Depending on
> which one it is, the start of node 1 may not be MAX_ORDER-aligned, gets
> overlapped with node-0 and goes downhill from there.
>   
The kernel is configured with 64K pages.

Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
