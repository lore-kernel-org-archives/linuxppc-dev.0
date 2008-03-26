Return-Path: <dgibson@ozlabs.org>
Date: Thu, 27 Mar 2008 10:37:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/2] [MTD] Add support for RAM & ROM mappings in the
	physmap_of MTD driver.
Message-ID: <20080326233725.GB8005@localhost.localdomain>
References: <200803261344.03438.laurentp@cse-semaphore.com>
	<346860fa1e8a75a4a89e260011690659@kernel.crashing.org>
	<47EA6B11.7050804@ru.mvista.com>
	<777c028aa41fe870542afdb4fa7d2db6@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <777c028aa41fe870542afdb4fa7d2db6@kernel.crashing.org>
Cc: ben@simtec.co.uk, linux-mtd@lists.infradead.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 26, 2008 at 04:34:58PM +0100, Segher Boessenkool wrote:
>>>>      {
>>>> +        .compatible    = "physmap-ram",
>>>> +        .data        = (void *)"map_ram",
>>>> +    },
>>>> +    {
>>>> +        .compatible    = "physmap-rom",
>>>> +        .data        = (void *)"map_rom",
>>>> +    },
>>
>>> Why the cast?  It's redundant afaics.
>>
>>   To be in line with the surrounding code...
>
> I see _that_, but it's not a great argument IMNSHO.  Could I trick
> you into preceding this patch with a cleanup patch for the existing
> casts?

Hrm.  Much as I generally dislike redundant casts, these ones do serve
to inform the reader that the data field is not always a string, which
they might otherwise assume.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
