Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C5886DDE41
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2007 00:08:52 +1000 (EST)
In-Reply-To: <20070817090535.0586160a@weaponx.rchland.ibm.com>
References: <Pine.LNX.4.64.0708170847120.29396@blarg.am.freescale.net>
	<20070817090535.0586160a@weaponx.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B4F8C3D2-2813-445A-BB7D-B1F855ADCF79@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: RFC: [PATCH] Fixup modpost warnings in head*.S for ppc32
Date: Fri, 17 Aug 2007 09:10:10 -0500
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 17, 2007, at 9:05 AM, Josh Boyer wrote:

> On Fri, 17 Aug 2007 08:48:40 -0500 (CDT)
> Kumar Gala <galak@kernel.crashing.org> wrote:
>
>> diff --git a/arch/powerpc/kernel/head_4xx.S b/arch/powerpc/kernel/ 
>> head_4xx.S
>> index adc7f80..a0c9151 100644
>> --- a/arch/powerpc/kernel/head_4xx.S
>> +++ b/arch/powerpc/kernel/head_4xx.S
>> @@ -53,9 +53,9 @@
>>   *
>>   * This is all going to change RSN when we add bi_recs.......  --  
>> Dan
>>   */
>> -	.text
>> -_GLOBAL(_stext)
>> -_GLOBAL(_start)
>> +	.section	.text.head, "ax"
>> +_ENTRY(_stext);
>> +_ENTRY(_start);
>
> FYI, I renamed this file to head_40x.S in my current for-2.6.24
> series.  Hopefully Paul will pull that soon.

sure, will rebase this once its ready, and hopefully Paul will have  
your 40x support in his for-2.6.24 tree.

- k
