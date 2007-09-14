Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id CFCB0DDE32
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 00:32:35 +1000 (EST)
Message-ID: <46EA9B44.6030606@ru.mvista.com>
Date: Fri, 14 Sep 2007 18:31:32 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] PowerPC: usb ehci of_platform bindings for Sequoia 440EPx
References: <20070913182453.GA26541@ru.mvista.com>
	<2c5fb8f063c275286b6b26ca734ed64d@kernel.crashing.org>
In-Reply-To: <2c5fb8f063c275286b6b26ca734ed64d@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>> EHCI OF bindings for PowerPC 440EPx Sequoia.
> 
> Those aren't bindings, they are examples.  Bindings are pieces
> of documentation that describe what device-specific properties
> mean what, what standard properties are required with what
> values, etc.
> 
> Examples are good to have, of course.
> 
> One thing you really need to document is what "ehci-be-desc"
> and friends mean.  I can give you one comment already: for
> devices that are usually little-endian, but an implementation
> implements registers as big-endian, precedent is to show that
> in the device tree by including an (empty) "big-endian" property,
> rather than inventing new "compatible" values.

I was looking at the ohci-ppc-of driver that has "ohci-bigendian" 
compatible string and enables both be-mmio and be-desc for the device in 
this case. I just wanted to separate mmio and desc stuff for ehci, since 
some devices need be-mmio only.
I'll use "big-endian" property instead of "ehci-be-mmio" compatible 
value. That's a good point, thanks.
Do I have to add "sequoia usb ehci" description to 
Documentation/powerpc/booting-without-of.txt?
Do I also have to describe ehci-ppc-of stuff in general?
BTW, I see nothing about ohci-ppc-of there.
Thanks,
Valentine.

> 
> 
> Segher
> 
