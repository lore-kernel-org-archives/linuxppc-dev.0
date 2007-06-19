Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B5C0EDDF2E
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 16:44:35 +1000 (EST)
In-Reply-To: <20070619012557.GB24530@localhost.localdomain>
References: <111819314606b8b45671.846930886.miltonm@bga.com>
	<4672EE95.3030407@freescale.com>
	<fbae4506b772f07d2a8c1d230bea82c8@bga.com>
	<bfbd4f126c427f590198a3e50a789b0c@kernel.crashing.org>
	<20070619012557.GB24530@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b563fc486105742f2a75a862bdaab20c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] boot: find initrd location from device-tree
Date: Tue, 19 Jun 2007 08:44:28 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> As I said in the patch changelog, the only headers picked up here are
>>> libgcc.
>>
>> Which the kernel doesn't use.  It _should_ be fine
>> nevertheless, <limits.h> is part of the "freestanding"
>> headers -- why do you need to do a "libc" trick though?
>> This doesn't work when not using glibc I guess?
>
> IMO if it needs this define magic to work properly, it's not a good
> idea to include it at all.  Especially since avoiding it is easy and
> safe in this case.

100% agreed.


Segher
