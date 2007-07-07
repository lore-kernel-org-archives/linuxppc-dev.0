Return-Path: <ahuja@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6B7D9DDFF4
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Jul 2007 06:26:27 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l67KQMvY011085
	for <linuxppc-dev@ozlabs.org>; Sat, 7 Jul 2007 16:26:22 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l67KQMHY218490
	for <linuxppc-dev@ozlabs.org>; Sat, 7 Jul 2007 14:26:22 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l67KQM4C028017
	for <linuxppc-dev@ozlabs.org>; Sat, 7 Jul 2007 14:26:22 -0600
Message-ID: <468FF6EC.6030301@austin.ibm.com>
Date: Sat, 07 Jul 2007 15:26:20 -0500
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH] pseries: Re: Minor: Removed double return.
References: <468EBB5B.2070309@austin.ibm.com>
	<20070706225826.GE4457@austin.ibm.com>
In-Reply-To: <20070706225826.GE4457@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ah yes, my mistake. Does it require a repost then ?

Thanks,
Manish

Linas Vepstas wrote:
> You want to say its a patch in the subject line.
>
> --linas
>
> On Fri, Jul 06, 2007 at 04:59:55PM -0500, Manish Ahuja wrote:
>   
>> Found 2 instances of return one right after each other in 
>> arch_add_memory(). This minor patch fixes it.
>> Signed-off-by:Manish Ahuja <mahuja@us.ibm.com>
>>
>>
>>     
>
>   
>> Index: 2.6.22-rc4/arch/powerpc/mm/mem.c
>> ===================================================================
>> --- 2.6.22-rc4.orig/arch/powerpc/mm/mem.c	2007-06-11 21:10:46.000000000 -0500
>> +++ 2.6.22-rc4/arch/powerpc/mm/mem.c	2007-06-29 22:52:42.000000000 -0500
>> @@ -129,8 +129,6 @@
>>  	zone = pgdata->node_zones;
>>  
>>  	return __add_pages(zone, start_pfn, nr_pages);
>> -
>> -	return 0;
>>  }
>>  
>>  /*
>>     
>
>   
