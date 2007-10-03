Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DDCE4DDE09
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 08:11:02 +1000 (EST)
In-Reply-To: <fa686aa40710031117x528e5afarb059d8f1c9eb3e7f@mail.gmail.com>
References: <87lkakxky1.fsf@macbook.be.48ers.dk>
	<fa686aa40710030856u74054993q2d73cf18920665f2@mail.gmail.com>
	<874ph8xjz1.fsf@macbook.be.48ers.dk>
	<fa686aa40710031117x528e5afarb059d8f1c9eb3e7f@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <436E14BA-FDF5-4F7A-A504-E28B38FA8A67@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] fsl_spi_init: Support non-QE processors
Date: Wed, 3 Oct 2007 17:11:05 -0500
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 3, 2007, at 1:17 PM, Grant Likely wrote:

> On 10/3/07, Peter Korsgaard <jacmet@sunsite.dk> wrote:
>>>>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:
>>
>> Hi,
>>
>>  Grant> Why not just:
>>
>>  Grant>         np = of_find_node_by_type(NULL, "qe");
>>  Grant> +       if (!np)
>>  Grant> +               np = of_find_node_by_type(NULL, "soc");
>>  Grant>         if (!np)
>>  Grant>                 return -ENODEV;
>>
>> My first iteration did it like that, but then you don't get a -ENODEV
>> if the node is missing (and you'll end up using the wrong clock) and
>> it doesn't support processors with SPI on and off QE (if that
>> exists/will ever exist).
>
> Okay, but you should at least be able confine your determination of
> which sysclk value to use to one part of the function.  Otherwise, it
> looks good.

Peter, can you respin this w/Grant's modification.  I've grabbed the  
other patches and applied them.  waiting on this one.

- k
