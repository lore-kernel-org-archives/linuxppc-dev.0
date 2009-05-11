Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EF1C1DDDF0
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 03:07:13 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id n4BH5Dbd017807
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 03:05:13 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4BH7CUi336380
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 03:07:12 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4BH7CYa031760
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 03:07:12 +1000
Message-ID: <4A085B3D.5000806@in.ibm.com>
Date: Mon, 11 May 2009 22:37:09 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Jiri Pirko <jpirko@redhat.com>
Subject: Re: [PowerPC] Next May 8 boot failure: OOPS during ibmveth moduleinit
References: <20090508180251.f53f204e.sfr@canb.auug.org.au>
	<4A042B20.4090903@in.ibm.com>
	<20090508.125722.54378771.davem@davemloft.net>
	<20090508223332.GA4881@psychotron.englab.brq.redhat.com>
In-Reply-To: <20090508223332.GA4881@psychotron.englab.brq.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, linux-next@vger.kernel.org,
	David Miller <davem@davemloft.net>, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jiri Pirko wrote:
> Fri, May 08, 2009 at 09:57:22PM CEST, davem@davemloft.net wrote:
>   
>> From: Sachin Sant <sachinp@in.ibm.com>
>> Date: Fri, 08 May 2009 18:22:48 +0530
>>
>>     
>>> Todays Next failed to boot on a Power6 JS22 blade with following oops.
>>>       
>> Jiri, I suspect this might be your address list changes.
>>
>> Although that's just a guess.  But please take a look.
>>     
>
> Hmm, only thing I see might cause the problem would be if calling __hw_addr_add
> in dev_addr_init fails, then dev->dev_addr would contain zeroes (which looks
> this is not the case). But in this case the oops would appear earlier (in
> ibmveth_probe dev_addr memcpy).
>
> Will do the patch which checks the result to behave correctly in case of oom
> but this imho this wouldn't help. Strange, I will dig into this more tomorrow.
>   
I can recreate this problem with today's Next release as well. Let me 
know if you want me to try
out any thing to debug this problem.

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
