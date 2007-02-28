Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9D295DDEB7
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Feb 2007 12:09:56 +1100 (EST)
In-Reply-To: <20070228005615.GE11775@localhost.localdomain>
References: <200702272254.l1RMsjt2030709@ld0164-tx32.am.freescale.net>
	<20070228005615.GE11775@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <58f8dd3e83ff9ec2936e4cc735d9ff25@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] powerpc: Document new property called interrupt-parents
Date: Wed, 28 Feb 2007 02:09:49 +0100
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Stuart Yoder <b08248@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> +Note: each interrupt parent in the interrupt-parents array can
>> +potentially specify a different value for #interrupt-cells.  The 
>> number
>> +of #interrupt-cells for each parent must be determined to correctly
>> +parser the interrupts property.
>
> I suggest your example actually show this case, since it's the more
> general.

But it won't very likely happen in reality, unlike
the nested-identical-PICs case.


Segher
