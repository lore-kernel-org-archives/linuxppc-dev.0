Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 619E6DDF75
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 09:36:18 +1000 (EST)
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts
	file.
In-Reply-To: Your message of "Fri, 01 Jun 2007 20:58:02 +0200."
	<dfc15991e31bfc09389461dc443acd7c@kernel.crashing.org>
References: <1180720112.14219.62.camel@ld0161-tx32>
	<dfc15991e31bfc09389461dc443acd7c@kernel.crashing.org>
Date: Fri, 01 Jun 2007 18:36:12 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1HuGfE-0007zw-EH@jdl.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Segher Boessenkool mumbled:
> 
> "reg" included in "ranges"?  Something is wrong here.
> 
> You map the same range (4kB legacy I/O @ 0) for both
> bridges here.
> 
> And this address space is included in both of those.
> 
> These need a "reg" property.
> 
> Inclusive again.

> Needs "reg".  And 4d0 isn't the primary address
> I think?

And none of this could have been said earlier when
Wade first posted the patch?

jdl
