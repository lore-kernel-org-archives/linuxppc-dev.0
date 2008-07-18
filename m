Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CC8ABDDFFF
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jul 2008 01:28:13 +1000 (EST)
Message-Id: <1346C86E-3B52-4920-9140-5D913DFC6D37@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
In-Reply-To: <200807181707.56921.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCHv3 1/2] [POWERPC] CPM2: Implement GPIO LIB API on CPM2
	Freescale SoC.
Date: Fri, 18 Jul 2008 10:28:02 -0500
References: <4808D75B.9000002@scram.de>
	<200807181638.42485.laurentp@cse-semaphore.com>
	<97D0950D-BBCA-4859-936E-774D887B05DC@kernel.crashing.org>
	<200807181707.56921.laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 18, 2008, at 10:07 AM, Laurent Pinchart wrote:

> On Friday 18 July 2008, Kumar Gala wrote:
>>
>> On Jul 18, 2008, at 9:38 AM, Laurent Pinchart wrote:
>>
>>> On Friday 27 June 2008, Jochen Friedrich wrote:
>>>> Hi Laurent,
>>>>
>>>>> Is there any pending issue or can this be applied to powerpc- 
>>>>> next ?
>>>>
>>>> Looks OK to me.
>>>>
>>>>>> Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
>>>>>> Cc: Jochen Friedrich <jochen@scram.de>
>>>> Acked-by: Jochen Friedrich <jochen@scram.de>
>>>
>>> Any news on this patch ? Kumar, could you apply it to your tree for
>>> 2.6.27 ?
>>
>> Can you repost it.  I not sure what patch 2/2 was and if I've already
>> dealt with it.
>
> 2/2 was "[PATCH2/2] [POWERPC] CPM1: implement GPIO LIB API on CPM1  
> Freescale SoC." posted by Jochen Friedrich. You haven't dealt with  
> it yet as far as I know, but it would be up to Jochen to resubmit.

Since it sounds like CPM1 and CPM2 gpio are different I'd like a new  
patch.  I'll send comments on v3.

> The "PATCHv3 1/2" patch can be considered as-is, as it doesn't  
> depend on 2/2. Should I resubmit a "PATCHv4" that just changes the  
> subject line ?

You can generate a v4 w/my desired changes.

- k
