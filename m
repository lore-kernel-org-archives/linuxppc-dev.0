Return-Path: <sachinp@in.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [59.145.155.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp02.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 23486DDEF0
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 21:36:15 +1100 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp02.in.ibm.com (8.13.1/8.13.1) with ESMTP id n13AaAQ3029321
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Feb 2009 16:06:10 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n13AXqVA3948596
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Feb 2009 16:03:52 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.13.1/8.13.3) with ESMTP id n13AaAoE032361
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Feb 2009 21:36:10 +1100
Message-ID: <49881E19.7050006@in.ibm.com>
Date: Tue, 03 Feb 2009 16:06:09 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PowerPC] 2.6.29-rc3-git4 build break : truncated relocation
References: <49880C42.8060702@in.ibm.com>
	<20090203210311.45fcad19.sfr@canb.auug.org.au>
In-Reply-To: <20090203210311.45fcad19.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@ozlabs.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> Hi Sachin,
>
> To make allyesconfig build currently, you need to turn
> CONFIG_PROFILE_ALL_BRANCHES off.  It makes drivers/built-in.o too large
> (increases the text size from about 32M to 47M) and the linker can't add
> the usual trampolines because we prelink it.
>   
Ok will enable this option. Thanks

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
