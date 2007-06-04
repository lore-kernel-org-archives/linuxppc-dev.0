Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 62BEFDDE06
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 18:07:43 +1000 (EST)
In-Reply-To: <466323EF.5040807@ru.mvista.com>
References: <7fc919fce0761f861be3069a853d3169@bga.com>
	<bd6ef296692e8cfb81118f2dc85189a5@kernel.crashing.org>
	<4662EAA9.70104@ru.mvista.com>
	<e4197fd2753f2b4d548d5dde9e3fd1d3@kernel.crashing.org>
	<466308F4.8050004@ru.mvista.com>
	<8ac5664208e0f59329b62ac2138bbc8c@kernel.crashing.org>
	<466312C2.4090200@ru.mvista.com>
	<548a7e11ffb577f6395b8f5a9c2fba2d@kernel.crashing.org>
	<466323EF.5040807@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <193459b778ff98aa95ee7ac38a842c16@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Date: Mon, 4 Jun 2007 10:07:34 +0200
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> This has nothing to do with a "chip level", it is plain and
>>>> simply the most basic device tree stuff.
>
>>>    If it was as "plain and simple" as you say, there would be 
>>> nothing to argue about.
>
>> There isn't as far as I am concerned; the purpose and
>> meaning of the "compatible" property, as well as of any
>> other standard OF properties, is clear.
>
>    Erm, concerning matching those with drivers it wasn't as clear that 
> those props aren't the same as driver names b/c of the follwing 
> passage in Generic Names:

[huge snip]

Please point out the exact passage you don't understand, and
what you don't understand about it, if you want any help.

>> Yes, the more complex (and sometimes insane) ways that
>> flash chips are connected to systems can be really hard
>> to describe properly.  Which is why I don't even want
>> to make a "binding" for it (yet).  It seems easy enough
>
>    Neither do we. :-)
>
>> to do this for single flash chips (possibly direct-mapped)
>> though.
>
>    Erm, FSL boards seem to generally have dual 16-bit NOR flash chips 
> interleaved -- and that's seems quite a common case, not only in PPC 
> world.

It's not all that common; I can see why it would be used on
flash controllers that handle a 32-bit bus only.

>    Perhaps... those interleaved chips could really be merged 
> (abstracted) into a single one, with the bus width being a sum of two?

Perhaps.  It is a nasty situation, it'll take long hard
thinking to come up with a reasonably good solution.

>>  Get the simple cases
>> (that actually are used in real life) right, first.
>
>    We pursued this task exactly. Get it working, quick. :-)

That is something *TOTALLY DIFFERENT* and quite a bad plan
IMNSHO.


Segher
