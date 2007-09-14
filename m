Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6BC05DDE11
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 01:32:14 +1000 (EST)
In-Reply-To: <46EA9B44.6030606@ru.mvista.com>
References: <20070913182453.GA26541@ru.mvista.com>
	<2c5fb8f063c275286b6b26ca734ed64d@kernel.crashing.org>
	<46EA9B44.6030606@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A0F54060-0F39-4AAD-94DA-CA16AC0D4E1C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] PowerPC: usb ehci of_platform bindings for Sequoia 440EPx
Date: Fri, 14 Sep 2007 10:35:05 -0500
To: Valentine Barshak <vbarshak@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 14, 2007, at 9:31 AM, Valentine Barshak wrote:

> Segher Boessenkool wrote:
>>> EHCI OF bindings for PowerPC 440EPx Sequoia.
>>
>> Those aren't bindings, they are examples.  Bindings are pieces
>> of documentation that describe what device-specific properties
>> mean what, what standard properties are required with what
>> values, etc.
>>
>> Examples are good to have, of course.
>>
>> One thing you really need to document is what "ehci-be-desc"
>> and friends mean.  I can give you one comment already: for
>> devices that are usually little-endian, but an implementation
>> implements registers as big-endian, precedent is to show that
>> in the device tree by including an (empty) "big-endian" property,
>> rather than inventing new "compatible" values.
>
> I was looking at the ohci-ppc-of driver that has "ohci-bigendian"
> compatible string and enables both be-mmio and be-desc for the  
> device in
> this case. I just wanted to separate mmio and desc stuff for ehci,  
> since
> some devices need be-mmio only.
> I'll use "big-endian" property instead of "ehci-be-mmio" compatible
> value. That's a good point, thanks.
> Do I have to add "sequoia usb ehci" description to
> Documentation/powerpc/booting-without-of.txt?
> Do I also have to describe ehci-ppc-of stuff in general?
> BTW, I see nothing about ohci-ppc-of there.

We may need to comprehend the Freescale USB controller since its  
technically an EHCI controller.  There should be some stuff in  
booting-without-of.txt related to it.

- k
