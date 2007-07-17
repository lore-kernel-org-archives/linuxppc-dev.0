Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 374A2DDE07
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 02:39:40 +1000 (EST)
In-Reply-To: <1184689617.15570.1.camel@weaponx.rchland.ibm.com>
References: <E1IAnwC-0003Xm-6U@jdl.com>
	<630B6BC9-389F-4F5C-AE8F-9C3131C4543E@kernel.crashing.org>
	<1184689617.15570.1.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <09A6A42B-8BFA-4AF1-BAC9-8EDA0EC60F40@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Add StorCenter DTS first draft.
Date: Tue, 17 Jul 2007 18:38:40 +0200
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +	flash@ff800000 {
>>> +		device_type = "rom";
>>
>> I'm sure you know I find this "rom" binding to be crap.
>> However, I didn't yet write up the "cfi" binding, so I
>> can't complain ;-)
>
> Not all chips are CFI compliant.

I know :-)

> Be sure to write up the "jedec"

It's in the pipeline, it's quite a bit more complicated
than CFI though.

> and "nand" bindings while you're at it ;)

NAND is pure hell :-(


Segher
