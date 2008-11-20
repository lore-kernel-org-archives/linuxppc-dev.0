Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9C3A5DDDEE
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 03:01:08 +1100 (EST)
Message-Id: <711D3B59-EAA3-4FA7-AD17-1573F8D57600@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
In-Reply-To: <200811201657.44240.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] cpm2: Round the baud-rate clock divider to the nearest
	integer.
Date: Thu, 20 Nov 2008 10:00:54 -0600
References: <200811201332.24061.laurentp@cse-semaphore.com>
	<644D289D-7057-44F4-B444-E60402E06912@freescale.com>
	<200811201657.44240.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, vbordug@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 20, 2008, at 9:57 AM, Laurent Pinchart wrote:

> Hi Kumar,
>
> On Thursday 20 November 2008 16:32:21 Kumar Gala wrote:
>> On Nov 20, 2008, at 6:32 AM, Laurent Pinchart wrote:
>>> Instead of rounding the divider down, improve the baud-rate  
>>> generators
>>> accuracy by rounding to the nearest integer.
>>>
>>> Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
>>> ---
>>> arch/powerpc/sysdev/cpm2.c |    3 ++-
>>> 1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> is this fixing a bug or just making things better?
>
> I guess it depends on your definition of bug :-) The problem has  
> always been
> present in the kernel sources, and people seem to have coped with it  
> until
> today. It is still a bug in my opinion, but I suppose the patch can  
> wait until
> 2.6.29 especially if we want to get it tested (it slightly changes  
> baud rates
> after all).

Ok. I'll put this in the .29 queue.  Can you provide a bit more detail  
on the issue this is resolving.

- k
