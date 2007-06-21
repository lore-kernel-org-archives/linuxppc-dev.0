Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-15.arcor-online.net (mail-in-15.arcor-online.net
	[151.189.21.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A414BDDEDF
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 01:00:40 +1000 (EST)
In-Reply-To: <20070621132851.25900@gmx.net>
References: <20070618185715.321010@gmx.net>	
	<20070619054232.GB32039@localhost.localdomain>
	<1182429733.24740.12.camel@localhost.localdomain>
	<20070621132851.25900@gmx.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Message-Id: <6c6c68fe62bf158c611c71699fc0bfcc@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] Device tree for new desktop platform in arch/powerpc
Date: Thu, 21 Jun 2007 16:59:33 +0200
To: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Cc: david@gibson.dropbear.id.au, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>               reserved-interrupts =3D <2>;
>>
>> I'm currious about the above though, what is it ?
>
> Quote from the CHRP ISA interrupt controller device binding document:
> =93reserved-interrupts=94
> Standard property name to define reserved interrupts.
> prop-encoded-array: An integer array, encoded with encode-int.
> The value of this property shall be a list of ISA interrupts which=20
> cannot
> be assigned due to cascading, wiring, or other reasons. Only the irq#=20=

> part
> of the property is pertinent to this use.

I never found any situation where this property is useful
(you need a lot more information to do anything but static
IRQ routing on ISA anyway), but it doesn't harm anything
either.


Segher
