Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BF00BDDDDB
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 09:17:29 +1000 (EST)
In-Reply-To: <1179938586.11247.62.camel@pterry-fc6.micromemory.com>
References: <1179862732.25914.40.camel@pterry-fc6.micromemory.com>
	<46B96294322F7D458F9648B60E15112C234AE6@zch01exm26.fsl.freescale.net>
	<Pine.LNX.4.64.0705230916170.535@localhost.localdomain>
	<1179934657.11247.14.camel@pterry-fc6.micromemory.com>
	<836bca7802dca173490f4d38e0c48b7a@kernel.crashing.org>
	<1179937253.11247.44.camel@pterry-fc6.micromemory.com>
	<Pine.LNX.4.64.0705231119271.1028@localhost.localdomain>
	<1179938586.11247.62.camel@pterry-fc6.micromemory.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <19cfc88d1980974176dd8d315c49e597@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Porting RapidIO from ppc arch to powerpc arch in support of
	MPC8641D
Date: Thu, 24 May 2007 01:17:20 +0200
To: pterry@micromemory.com
Cc: linuxppc-dev@ozlabs.org, Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> OK, but if the device tree is not allowed to dictate policy, to use
> Segher's term, just hardware characteristics, how does that help us get
> the embedded soc kernels away from being designed and built to specific
> demo/eval board setups and make them more configurable?

I don't see the problem really.  Could you point out one
specific problem, and then we solve it?  Repeat as necessary.

> I got the impression that to some extent thats how you/we/?? were 
> trying
> to use the dts stuff. If my board is exactly like freescales xyz demo
> board except I move my rio map to here, my pci map to here, change a 
> few
> sizes etc., why do I have to go and patchup the arch setup code, modify
> ppc_md routines, etc.

That shouldn't be necessary.

> Isn't the plan that I just edit the dts, compile
> with dtc and have u-boot pass in the dtb to the stock kernel and its
> boots on my board?

Mostly, yes.

> If dts can't do this because its not allowed policy statements then 
> what
> will do this?

You pass policy decisions to the kernel some other way.  Like,
on the kernel command line, for example.

> Segher is right,

Yes, I always am.

> Please I'm not trying to start up any previous turf wars here,

Much appreciated!

--

Okay, if I am to help at all here, please someone explain what
"law"s and mboxes and doorbells are (in the context of rapidio).
Also how they are used, etc.


Segher
