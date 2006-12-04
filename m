Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B16C267C1E
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 07:30:33 +1100 (EST)
In-Reply-To: <C8D32511-EE52-4745-99C7-30039FA02F21@freescale.com>
References: <Pine.LNX.4.61.0612011153500.15004@ld0175-tx32.am.freescale.net>
	<B9050CFE-9237-4024-9B1A-6940339FD0F1@kernel.crashing.org>
	<C8D32511-EE52-4745-99C7-30039FA02F21@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <57683779-78D8-40EE-B87E-3F829AC39EEE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2.6.20] powerpc: Changed gianfar device tree definition to
	make it more flexible
Date: Mon, 4 Dec 2006 14:30:23 -0600
To: Andy Fleming <afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 4, 2006, at 2:08 PM, Andy Fleming wrote:

>
> On Dec 1, 2006, at 12:52, Kumar Gala wrote:
>
>> [snip]
>>
>>> +  Optional properties (features):
>>> +    - gigabit : Indicates support for 1000 Mbit operation
>>> +    - coalescing : Indicates support for interrupt coalescing
>>> +    - rmon : Indicates support for RMON-style counters
>>> +    - checksumming : Indicates support for hardware TCP/UDP  
>>> checksumming
>>> +    - vlan-insertion : Indicates support for hardware vlan  
>>> header insertion
>>> +    - extended-hash : Indicates support for using the Individual
>>> +        Address Hash registers to extend the Group Address Hash  
>>> registers
>>> +    - padding : Indicates support for padding between the FCB and
>>> +        the frame
>>> +    - filer : Indicates support for the Filer
>>> +    - parseL2 : Indicates support for parsing L2 headers
>>> +    - parseL3 : Indicates support for parsing L3 headers
>>> +    - parseL4 : Indicates support for parsing L4 headers
>>
>> I'm still think that filer, parseL2, parseL3, parseL4 should be  
>> folded into one attribute. Unless there are plans for version that  
>> only do some subset.
>
> I was told that it would be good to separate them.  I can pursue  
> this further, but until there's code that uses these bits, they're  
> not too important.  Can we let this through, with the proviso that  
> I'll change it?  I'm more concerned about getting the code in,  
> right now.

Told by whom?  I'm not in favor of letting this in because its a  
interface we dont want to be changing.  I can list at all the reasons  
we dont want to, but I think you get the point.

>>> +    - multi-queue : Indicates support for sending and receiving
>>
>> We may want to split this into multi-queue = 4 or something to  
>> spec how many.  Also you may want to split this into tx-multi- 
>> queue and rx-multi-queue.  I can for see have non-equal numbers  
>> for them.
>
>
> Hmm.  Yeah, that makes sense.  My comment from above applies again,  
> though.  Can we let it through, with the proviso that I will change  
> it in a forthcoming patch?  There's no code actually *using* these  
> bits right now, but I need to look into the parse/filer bits, and I  
> need to think about the multiqueue stuff.

See my comment about about interfaces.

>>> +      into multiple queues
>>> +    - buffer-stashing : Controller can allocate buffers into L2
>>> +    - buffer-locking : Controller can lock buffers into L2
>>> +    - bd-stashing : Controller can allocate descriptors into L2
>>> +    - bd-locking : Controller can lock descriptors into L2
>>> +
>>
>>
>> Also
>
> On the other hand
>
>
> Andy
