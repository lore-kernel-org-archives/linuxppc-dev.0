Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 54ACD67B54
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 01:28:37 +1000 (EST)
In-Reply-To: <995B09A8299C2C44B59866F6391D263511B9EA@zch01exm21.fsl.freescale.net>
References: <995B09A8299C2C44B59866F6391D263511B9EA@zch01exm21.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <43765FEB-22D2-4435-A074-7DEF969E466B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [QUESTION] Enable coherency for all pages on 83xx to fix PCI data
	corruption
Date: Tue, 29 Aug 2006 10:28:23 -0500
To: Liu Dave-r63238 <DaveLiu@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 28, 2006, at 9:04 PM, Liu Dave-r63238 wrote:

>> This was to address PCI5 if I remember correctly.
>>
>> - kumar
>>
>> On Aug 28, 2006, at 2:49 AM, Liu Dave-r63238 wrote:
>>
>>> All,
>>>
>>> I want to know which PCI errata is solved by this patch and if this
>>> patch did test on real hardware.
>>>
>>> I know this patch turn on the 'M' bit -memory coherency.
>>> But I don't believe this can solved the "PCI read multi-line"
>>> errata.
>>>
>>> -DAve
> <snip>
>
> I also don't believe this patch can solve the PCI5 errata, The PCI5
> description:
>
> When external PCI devices try to read from the memory which is defined
> as
> prefetchable and where the transaction is more than one cache line,
> there
> may be data corruption.


Randy may remember but this fixed an issue related that he was seeing  
with an e100 or e1000 and it was the solution provided by the  
Freescale Apps team in Austin.

- kumar
