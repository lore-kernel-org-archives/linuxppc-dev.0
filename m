Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5DAB3DDDDB
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 17:09:46 +1000 (EST)
In-Reply-To: <200707112256.38312.arnd@arndb.de>
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
	<1184162179.32199.58.camel@weaponx.rchland.ibm.com>
	<200707112256.38312.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2FE5C7E5-DF96-49C1-939E-39521A248F9B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH 3/8] 4xx MMU
Date: Thu, 12 Jul 2007 02:09:59 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 11, 2007, at 3:56 PM, Arnd Bergmann wrote:

> On Wednesday 11 July 2007, Josh Boyer wrote:
>> +#elif defined(CONFIG_40x)
>> +/* 40x-style software loaded TLB */
>> +#  include <asm/mmu-4xx.h>
>>  #elif defined(CONFIG_44x)
>>  /* 44x-style software loaded TLB */
>>  #  include <asm/mmu-44x.h>
>
> If you call it mmu-4xx, shouldn't it be used
> for 44x as well? I would think this either
> should be
>
>> +#elif defined(CONFIG_4xx)
>> +/* 40x-style software loaded TLB */
>> +#  include <asm/mmu-4xx.h>
>> -#elif defined(CONFIG_44x)
>> -/* 44x-style software loaded TLB */
>> -#  include <asm/mmu-44x.h>
>
> or
>
>> +#elif defined(CONFIG_40x)
>> +/* 40x-style software loaded TLB */
>> +#  include <asm/mmu-40x.h>
>>  #elif defined(CONFIG_44x)
>>  /* 44x-style software loaded TLB */
>>  #  include <asm/mmu-44x.h>
>
> Is it actually feasible to get to a point where
> you can build a kernel that boots on both
> 40x and 44x, or is it just too different?

I'm guessing its too different since 40x probably has a real mode and  
44x doesnt.

However, I agree we should go ahead and rename 4xx to 40x at this  
point in arch/powerpc.

- k
