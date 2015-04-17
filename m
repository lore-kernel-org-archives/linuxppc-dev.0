Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 6FE3A1A11BC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Apr 2015 02:26:04 +1000 (AEST)
Message-ID: <55313413.2050604@c-s.fr>
Date: Fri, 17 Apr 2015 18:25:55 +0200
From: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: David Laight <David.Laight@ACULAB.COM>,
 Kim Phillips <kim.phillips@freescale.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 David S Miller <davem@davemloft.net>
Subject: Re: [PATCH v3 03/17] crypto: talitos - talitos_ptr renamed ptr for
 more lisibility
References: <20150417142356.797BC1A242C@localhost.localdomain>
 <063D6719AE5E284EB5DD2968C1650D6D1CB21235@AcuExch.aculab.com>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CB21235@AcuExch.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 17/04/2015 17:14, David Laight a écrit :
> From: Christophe Leroy
>> Linux CodyingStyle recommends to use short variables for local
>> variables. ptr is just good enough for those 3 lines functions.
>> It helps keep single lines shorter than 80 characters.
> ...
>> -static void to_talitos_ptr(struct talitos_ptr *talitos_ptr, dma_addr_t dma_addr)
>> +static void to_talitos_ptr(struct talitos_ptr *ptr, dma_addr_t dma_addr)
>>   {
>> -	talitos_ptr->ptr = cpu_to_be32(lower_32_bits(dma_addr));
>> -	talitos_ptr->eptr = upper_32_bits(dma_addr);
>> +	ptr->ptr = cpu_to_be32(lower_32_bits(dma_addr));
>> +	ptr->eptr = upper_32_bits(dma_addr);
>>   }
> ...
>
> Maybe, but 'ptr' isn't a good choice.
>
>
Any suggestion ?

Christophe
