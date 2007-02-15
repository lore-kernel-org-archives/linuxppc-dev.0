Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B985FDDE3E
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 01:56:52 +1100 (EST)
In-Reply-To: <E1HHhCD-0004Hf-QT@jdl.com>
References: <20070213061026.5837FDDDE9@ozlabs.org>
	<e9a2d2be6fe9006c1e2e0b65099a1854@kernel.crashing.org>
	<20070214002210.GE11491@localhost.localdomain>
	<45afe653a3f963e21e58a063c09b1b22@kernel.crashing.org>
	<20070214231734.GC16279@localhost.localdomain>
	<90e2bb990b7e1f46c6eaccd1d9255d77@kernel.crashing.org>
	<E1HHhCD-0004Hf-QT@jdl.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <865018a527ef1056f628250167301e64@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony 
Date: Thu, 15 Feb 2007 15:56:41 +0100
To: Jon Loeliger <jdl@jdl.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> The first option.  Anywhere a number can be used, "d# xxx"
>> would mean decimal.
>>
>> When you would say <d# 1234  5678>, 1234 is decimal and
>> 5678 is hexadecimal.
>
> Where do the tokens end?  Is "d#1234" valid and equal to "d# 1234"?
> Or is "d#" an independent token?

In OF, there has to be whitespace inbetween.

> And are there other bases to
> this model?  Like, maybe, "b#", "o#" and "h#" as well?

o# d# h# are standard defined; b# exists on many implementations.

Neither b# nor o# is frequently used but there's no harm in
including them I suppose.


Segher
