Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7BA14DDEDF
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 04:47:11 +1000 (EST)
In-Reply-To: <46630A32.7000403@ru.mvista.com>
References: <7fc919fce0761f861be3069a853d3169@bga.com>
	<1180769992.14025.1.camel@localhost.localdomain>
	<4662E7EA.70506@ru.mvista.com>
	<d067769912d2ed5c9e1b4770b77303dd@kernel.crashing.org>
	<46630256.8050909@ru.mvista.com>
	<daa1b6f2e18f06f053d538d28d3c046a@kernel.crashing.org>
	<46630A32.7000403@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e85b2d39481e426dcd4c19a3eaaf8238@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Date: Sun, 3 Jun 2007 20:46:57 +0200
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, linux-mtd@lists.infradead.org,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Nobody's talking about the direct match but making the task of 
>>> selecting a proper driver more complex by specifying the details 
>>> that don't help (if not hinder) the correct selection is certainly 
>>> not a way to go.
>
>> Nonsense.  If the kernel doesn't care about certain details,
>> it can just ignore them.
>
>    That's OK, as long as it has the details it needs. Your suggestions 
> on the "compatible" devoided it of such.

Sigh.

[snip]

>>>    That's the way the cookie crumbles in Linux MTD for now. It's 
>>> *always* detecting this by probing -- you only can say what [not] to 
>>> probe.
>
>> So go fix that :-)
>
>    Wanna pay me for that? ;-)

You're the one complaining, you go pay yourself.

[snip, plunk]


Segher
