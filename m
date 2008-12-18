Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E0E0EDDEFE
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 05:48:34 +1100 (EST)
Message-Id: <2F0D6B80-F825-4697-AA55-13C786A3449E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20081218163640.GA21049@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 0/4] Few patches for galak/powerpc.git next
Date: Thu, 18 Dec 2008 12:46:26 -0600
References: <20081218163640.GA21049@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 18, 2008, at 10:36 AM, Anton Vorontsov wrote:

> Kumar, Timur,
>
> Much thanks for the reviews and comments, here is an updated patch  
> set.
>
> Changes:
> - BCSR GPIO bindings were split into a separate patch.
> - simple_gpiochip_init() return value changed to void (the function
>  prints errors by itself, and we don't check its return value anyway).
>
> p.s.
>>> +- reg : Should contain the address and the lenght of the GPIO bank
>>> +  register;
>>
>> spelling - length
>> semicolon at add of register can be dropped.
>
> Umm.. the semicolon denotes the end of the list item.
> Anyhow, I see that periods are used more widely, so I replaced
> semicolons with periods.
>

all applied

- k
