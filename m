Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E9AB1DDEE9
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 17:53:10 +1000 (EST)
In-Reply-To: <1182468325.24740.18.camel@localhost.localdomain>
References: <20070618185715.321010@gmx.net>
	<20070619054232.GB32039@localhost.localdomain>
	<1182429733.24740.12.camel@localhost.localdomain>
	<558860c3d90100cd18df5f9a66cce3f9@kernel.crashing.org>
	<1182468325.24740.18.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <be8290e4a9e76608b8ede05deaaf91af@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] Device tree for new desktop platform in arch/powerpc
Date: Fri, 22 Jun 2007 09:52:59 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: list <linuxppc-dev@ozlabs.org>, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> The "#address-cells" property should be completely absent,
>> even; for interrupt matching, that means "treat as 0, no
>> unit address used in interrupt mapping, just the interrupt
>> number", and for the "normal" purpose (defining the format
>> of devices on the bus rooted at / represented by this node)
>> it means "there is no such bus" -- this is different from
>> #address-cells = 0.
>
> I'd rather have it present and explicitely set to 0,

It is not the "right thing" to do, but should be harmless
in most situations.

> which happens to be
> what both Apple and IBM OF implementations also do. Have you verified 
> if
> the linux parser behaves properly if it's absent ?

No, I haven't.  I prefer following the standard instead of simply
making the code work with one or two implementations; I hope
you did the same :-)

If it doesn't work, it's simply a bug in Linux.


Segher
