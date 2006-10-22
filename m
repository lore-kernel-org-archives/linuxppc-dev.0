Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc1-s26.bay0.hotmail.com (bay0-omc1-s26.bay0.hotmail.com
	[65.54.246.98]) by ozlabs.org (Postfix) with ESMTP id 68BAE679E0
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 22 Oct 2006 21:40:09 +1000 (EST)
Message-ID: <BAY110-F14D14B6EBD6394F62C88A5B2030@phx.gbl>
In-Reply-To: <ff9652ca0610212348p42f46a52w9b147dc3d7ae1838@mail.gmail.com>
From: "Ming Liu" <eemingliu@hotmail.com>
To: rahul.theraja@gmail.com
Subject: Re: how to reserve memory in linux?
Date: Sun, 22 Oct 2006 11:40:04 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Rahul,

>why do you think so ?
>Can't you give the physical address of the allocated memory from 
>linux
>kernel to peripheral's DMA.?
>Unless you need to hardcode the physicall address i hope
>virt_to_phys(kmalloc_address) can be given to DMA.
>Sorry if i am still wrong in understanding your requirement.
>

In fact, I have considered this method before. Just to dynamically allocate 
such a memory buffer and then tell the peripheral its physical address for 
accessing. However, because I really know little about the memory 
management in Linux, so I am not sure if the following question could be 
guaranteed:
Q. When I dynamically allocate a large amount of memory, I am not sure if I 
can allocate a physically continous large amount of memory. For the 
peripheral, it hopes the continous physical address, unless it has 
scatter-gather function. 

I think I must dig deeply into LDD memory management chapter to find the 
answer. :)

Of course, I appreciate your idea and suggestion. This is really a 
candidate method to solve my problem.

Thanks a lot.
Regards
Ming

_________________________________________________________________
与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn  
