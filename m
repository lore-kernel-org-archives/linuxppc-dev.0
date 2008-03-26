Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0D67FDE30F
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 02:37:09 +1100 (EST)
In-Reply-To: <47EA6B11.7050804@ru.mvista.com>
References: <200803261344.03438.laurentp@cse-semaphore.com>
	<346860fa1e8a75a4a89e260011690659@kernel.crashing.org>
	<47EA6B11.7050804@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <777c028aa41fe870542afdb4fa7d2db6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/2] [MTD] Add support for RAM & ROM mappings in
	the	physmap_of MTD driver.
Date: Wed, 26 Mar 2008 16:34:58 +0100
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: ben@simtec.co.uk, linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>      {
>>> +        .compatible    = "physmap-ram",
>>> +        .data        = (void *)"map_ram",
>>> +    },
>>> +    {
>>> +        .compatible    = "physmap-rom",
>>> +        .data        = (void *)"map_rom",
>>> +    },
>
>> Why the cast?  It's redundant afaics.
>
>   To be in line with the surrounding code...

I see _that_, but it's not a great argument IMNSHO.  Could I trick
you into preceding this patch with a cleanup patch for the existing
casts?


Segher
