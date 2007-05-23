Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0C7E4DDD0A
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 02:00:44 +1000 (EST)
In-Reply-To: <Pine.LNX.4.64.0705230916170.535@localhost.localdomain>
References: <1179862732.25914.40.camel@pterry-fc6.micromemory.com>
	<46B96294322F7D458F9648B60E15112C234AE6@zch01exm26.fsl.freescale.net>
	<Pine.LNX.4.64.0705230916170.535@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0389b4398a09293e6b6e0e4304a81ebe@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Porting RapidIO from ppc arch to powerpc arch in support of
	MPC8641D
Date: Wed, 23 May 2007 18:00:38 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>                 interrupts = <30 1 31 1 32 1 35 1 36 1 37 1 38 1>;
>>>
>> Do you really use all of this interrupts? In my test, three <32 2 35 2
>> 36 2> are okay, and the sense is 2.
>
> I think we need to list all the interrupts possible from RIO, not just 
> the
> ones the driver happens to use.

Yes exactly; the device tree describes the hardware, not
the way that Linux (or any other OS) happens to use it.

The same holds for the "law", "doorbells", and "mailboxes"
properties -- I have no clue whether those are hardware
properties or what else, you guys figure it out :-)


Segher
