Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8CC95DDEBB
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 11:27:33 +1100 (EST)
In-Reply-To: <20070214231734.GC16279@localhost.localdomain>
References: <20070213061026.5837FDDDE9@ozlabs.org>
	<e9a2d2be6fe9006c1e2e0b65099a1854@kernel.crashing.org>
	<20070214002210.GE11491@localhost.localdomain>
	<45afe653a3f963e21e58a063c09b1b22@kernel.crashing.org>
	<20070214231734.GC16279@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <90e2bb990b7e1f46c6eaccd1d9255d77@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
Date: Thu, 15 Feb 2007 01:27:28 +0100
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> Can't you use decimal for these?
>>>
>>> dtc doesn't support decimal cells at present.  Suggest a good syntax
>>> for doing it, and I'll add the feature.
>>
>> d# 100000000    like is used in "real" OF?
>
> Sorry, I don't entirely follow.  How does this sit in the context of a
> dtc property definition? foo = <d# 100>;?  foo = d# 100 200;?

The first option.  Anywhere a number can be used, "d# xxx"
would mean decimal.

When you would say <d# 1234  5678>, 1234 is decimal and
5678 is hexadecimal.


Segher
