Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8ED40DDE40
	for <linuxppc-dev@ozlabs.org>; Sat,  5 May 2007 08:26:03 +1000 (EST)
Subject: Re: [PATCH] Remove CPU_FTR_NEED_COHERENT for 7448.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@jdl.com>
In-Reply-To: <E1HjzWH-0001Wg-Ps@jdl.com>
References: <1178141683.32136.46.camel@ld0161-tx32>
	<1178187440.20944.12.camel@localhost.localdomain>
	<1178208838.17201.52.camel@ld0161-tx32>
	<1178228208.6353.55.camel@localhost.localdomain>
	<E1HjzWH-0001Wg-Ps@jdl.com>
Content-Type: text/plain
Date: Sat, 05 May 2007 08:25:26 +1000
Message-Id: <1178317526.6353.106.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-05-04 at 10:16 -0500, Jon Loeliger wrote:
> So, like, the other day Benjamin Herrenschmidt mumbled:
> > 
> > I still maintain it should be a runtime thing tho :-)
> > 
> > Ben.
> 
> So, could you comment on my proposed solution doing
> things exactly this way?  Speifically, would folks
> prefer the dynamic 
> 
>     number_of_cpus() == 1 

Sorry I don't remember the actual patch, must have missed it... I
suppose we could have generic code in early_init_devtree set the default
for this based on cpu_possible_map() containing more than one bit and
have platforms using one of those broken bridges force the bit in from
their probe routine.

Ben.
