Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 01F94DDD0A
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 21:41:49 +1000 (EST)
In-Reply-To: <1184153248.6059.87.camel@localhost.localdomain>
References: <9094.1181275235@neuling.org>
	<1184149691.6059.82.camel@localhost.localdomain>
	<3269B7A5-2D77-4C4D-B28D-397CB73E8568@kernel.crashing.org>
	<1184153248.6059.87.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <72B5EA9F-9599-4898-AA74-067BF8F9F9FB@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] do firmware feature fixups after features are initialised
Date: Wed, 11 Jul 2007 13:41:24 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	paulus@samba.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> d) preload some SLB entries at very early boot to cover
>>     the first 4GB or so.
>>
>> d) sounds nice and simple, but will it work?
>
> Nah, best to limit everything at boot to SLB 0. Thing is, 4G is not
> enough, you may have more RAM and have allocations from the top.

Yeah fair enough.  You could of course preload the stuff at
the top then, but that could quickly become a nasty hack, too.


Segher
