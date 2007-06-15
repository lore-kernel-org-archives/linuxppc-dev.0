Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E2C68DDF52
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 18:16:15 +1000 (EST)
In-Reply-To: <20070614222620.GA17382@mag.az.mvista.com>
References: <1181729973.25586.31.camel@dolphin.spb.rtsoft.ru>
	<db0d38e5b5e1a9a3a7fe35d25ebd357a@kernel.crashing.org>
	<467176EB.7060404@ru.mvista.com>
	<20070614222620.GA17382@mag.az.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c6cd3a9fe7713f081354cca9b4306811@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH] powerpc: MPC7450 L2 HW cache flush feature utilization
Date: Fri, 15 Jun 2007 10:16:04 +0200
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>      /* TODO: use HW flush assist when available */
>>>
>>> You want to get rid of this old comment though -- and
>>> perhaps branch over the non-hardware-assisted cache
>>> flushing code.
>>
>> Ok, I agree that the comment is obsolete now. Would you please explain
>> why the branch over non-hardware-assisted code should be removed as
>> well. Technically the cache is flushed and there is no need to use 
>> extra
>> commands to fill and then re-flush the cache.
>
> I think Segher is saying that you can skip the manual invalidation too
> (although he said "flushing", I think he really meant "invalidation"--
> the manual flushing is already skipped).

Erm yes.

> If I'm reading the manual
> correctly, L2HWF does the invalidation as well so both the manual
> flushing and invalidation can be skipped.

Yeah.  Not that it really matters of course.


Segher
