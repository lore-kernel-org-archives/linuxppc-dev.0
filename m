Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3A6DDDDEC4
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 01:37:15 +1000 (EST)
In-Reply-To: <18076.42297.26124.137770@cargo.ozlabs.ibm.com>
References: <46B96294322F7D458F9648B60E15112C6F3D1E@zch01exm26.fsl.freescale.net>
	<4694F608.2090503@freescale.com>
	<368E1200-1315-4C24-9876-C92CCF65EFE3@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C6F3E42@zch01exm26.fsl.freescale.net>
	<1184260375.24515.35.camel@pterry-fc6.micromemory.com>
	<B2EA074C-5D8E-4E13-B6BF-E81FBA52E76E@kernel.crashing.org>
	<18076.42297.26124.137770@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3E9205E0-E634-4A3E-BDC1-5FB91A347D24@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4] Add DMA sector to
	Documentation/powerpc/booting-without-of.txt file.
Date: Tue, 17 Jul 2007 17:36:53 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, Wei.Zhang@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> The device tree describes _all_ hardware in the system,
>> not just the things that are somewhat harder to probe
>> for.
>
> Actually, for embedded systems, the device tree is really only
> required to describe the things that it's useful for the Linux kernel
> to know.

Sure, for example it could provide a "SoC" node with only
an address range, and not describe all the devices on that
SoC separately.  It still describes all of the hardware,
not in quite so much detail though.  It also won't get all
the benefits of using the OF device tree, but that is a
trade off, for each group to decide on their own.

> The point of the device tree for embedded systems is to provide
> configuration information, not to be able to claim compliance with
> some set of legalistic requirements. :)

Well, if you use some certain binding, you better use it
correctly, no?  Ill-defined and ill-used interfaces aren't
the nicest thing to deal with.

> I think in some cases we have gone a little over the top in trying to
> put everything in the device tree, in fact.  Ultimately I think it has
> to be up to the more experienced embedded developers to say how much
> detail in the device tree is actually helpful and how much is dead
> weight.

Yes, more complex device bindings need a lot of time to get
right, and need a lot of input from all parties using it.
In general, it is better to leave out things from a binding
until it is very clear it is needed and is the right thing
to do.


Segher
