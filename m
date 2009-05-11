Return-Path: <sachinp@in.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [59.145.155.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp03.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C012BDDD1C
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 02:20:02 +1000 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp03.in.ibm.com (8.13.1/8.13.1) with ESMTP id n4BGJvO1029529
	for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2009 21:49:57 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4BGJvxE1536240
	for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2009 21:49:57 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id n4BGJvHp026293
	for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2009 21:49:57 +0530
Message-ID: <4A08502B.9040001@in.ibm.com>
Date: Mon, 11 May 2009 21:49:55 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: Next May 11 : BUG during scsi initialization
References: <20090511161442.3e9d9cb9.sfr@canb.auug.org.au>
	<4A081002.4050802@in.ibm.com>
	<20090511115233.GB8112@parisc-linux.org>
	<4A081437.7000409@in.ibm.com>
	<20090511122135.GC8112@parisc-linux.org>
In-Reply-To: <20090511122135.GC8112@parisc-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Nick Piggin <npiggin@suse.de>, Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-scsi <linux-scsi@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Pekka Enberg <penberg@cs.helsinki.fi>, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matthew Wilcox wrote:
>> Default one. SLQB
>>
>> CONFIG_SLQB_ALLOCATOR=y
>> CONFIG_SLQB=y
>>
>> Page size is 64K with Config DEBUG_PAGEALLOC set.
>>
>> CONFIG_PPC_HAS_HASH_64K=y
>> CONFIG_PPC_64K_PAGES=y
>> CONFIG_DEBUG_PAGEALLOC=y
>>     
>
> Hm.  We've seen some similar problems at Intel while doing database
> performance tests with SLQB.  Any ideas, Nick?
>   
Yeah so the problem seems to be with SLQB. I was able to boot Next 11 with
SLUB on the same machine.

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
