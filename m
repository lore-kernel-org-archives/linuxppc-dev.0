Return-Path: <ptich@hotmail.com>
Received: from bay0-omc1-s13.bay0.hotmail.com (bay0-omc1-s13.bay0.hotmail.com
	[65.54.246.85]) by ozlabs.org (Postfix) with ESMTP id 9F7FB67C26
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 11:38:20 +1100 (EST)
Message-ID: <BAY102-F1446B29A3C6918114ADE69A9EA0@phx.gbl>
In-Reply-To: <28501EDE-38C4-45FB-8B23-7E01A1815407@kernel.crashing.org>
From: "M Ptich" <ptich@hotmail.com>
To: galak@kernel.crashing.org
Subject: Re: Low memory not pageable on Freescale BookE
Date: Wed, 15 Nov 2006 00:38:14 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>Why do you need low kernel memory to be pageable?

Mainly for debugging purposes - this way we can have guardbands for our 
application stacks, and also for proprietary software that tracks memory 
accesses (for corruption detection).

-Ptich

>>For our application, we need low memory to be mapped with pages,  but it
>>turned out that Freescale BookE maps it with TLB1. Was there any  
>>particular
>>reason why ? I am thinking of changing it, but wondering if there was
>>something fundamental behind it.
>
>Why do you need low kernel memory to be pageable?
>
>- kumar

_________________________________________________________________
All-in-one security and maintenance for your PC.  Get a free 90-day trial! 
http://clk.atdmt.com/MSN/go/msnnkwlo0050000002msn/direct/01/?href=http://www.windowsonecare.com/?sc_cid=msn_hotmail
