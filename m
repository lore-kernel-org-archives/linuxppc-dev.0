Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CAC32DDF06
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 23:11:33 +1000 (EST)
In-Reply-To: <20070424.212902.00454541.davem@davemloft.net>
References: <20070424.110456.124867547.davem@davemloft.net>
	<1177459651.14873.164.camel@localhost.localdomain>
	<c65c2fcf295f9b4a40292156b5258012@kernel.crashing.org>
	<20070424.212902.00454541.davem@davemloft.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3141ca4c9918b2da3184fb5de4a1674d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/6] Start split out of common open firmware code
Date: Wed, 25 Apr 2007 15:11:27 +0200
To: David Miller <davem@davemloft.net>
Cc: sfr@canb.auug.org.au, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> end up with the OF analogue to an MSI layer that only
>> ever can work on intel compatible platforms.
>
> Please don't use this straw-man.
>
> These days it works perfectly fine on sparc64.

Yes, but how long did that take?  And why? That's my
point, not that "after this things cannot be solved
anymore" -- sure they can, it gets a lot harder though.


Segher
