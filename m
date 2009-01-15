Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ED11ADDFB5
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 01:42:24 +1100 (EST)
Message-Id: <98B0EC36-C1AE-44F0-98CC-F1AED0B9E299@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
In-Reply-To: <200901151418.28882.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] cpm2: Round the baud-rate clock divider to the nearest
	integer.
Date: Thu, 15 Jan 2009 08:42:14 -0600
References: <200811201332.24061.laurentp@cse-semaphore.com>
	<200811201657.44240.laurentp@cse-semaphore.com>
	<711D3B59-EAA3-4FA7-AD17-1573F8D57600@kernel.crashing.org>
	<200901151418.28882.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, vbordug@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 15, 2009, at 7:18 AM, Laurent Pinchart wrote:

> Hi Kumar,
>
> On Thursday 20 November 2008 17:00:54 Kumar Gala wrote:
>> On Nov 20, 2008, at 9:57 AM, Laurent Pinchart wrote:
>>> On Thursday 20 November 2008 16:32:21 Kumar Gala wrote:
>>>> On Nov 20, 2008, at 6:32 AM, Laurent Pinchart wrote:
>>>>> Instead of rounding the divider down, improve the baud-rate
>>>>> generators
>>>>> accuracy by rounding to the nearest integer.
>>>>>
>>>>> Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
>>>>> ---
>>>>> arch/powerpc/sysdev/cpm2.c |    3 ++-
>>>>> 1 files changed, 2 insertions(+), 1 deletions(-)
>>>>
>>>> is this fixing a bug or just making things better?
>>>
>>> I guess it depends on your definition of bug :-) The problem has
>>> always been present in the kernel sources, and people seem to have  
>>> coped
>>> with it until today. It is still a bug in my opinion, but I  
>>> suppose the
>>> patch can wait until 2.6.29 especially if we want to get it tested  
>>> (it
>>> slightly changes baud rates after all).
>>
>> Ok. I'll put this in the .29 queue.  Can you provide a bit more  
>> detail
>> on the issue this is resolving.
>
> 2.6.29-rc1 is out and I haven't seen the patch being applied  
> anywhere. Is
> there any blocking issue ?

I wasn't sure if you and Scott had come to resolution on the rounding  
issue.

- k
