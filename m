Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A20F8DDFA2
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 08:49:52 +1000 (EST)
Subject: Re: Musings on PCI busses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20090520.154104.48737237.davem@davemloft.net>
References: <20090520.122453.169463011.davem@davemloft.net>
	<fa686aa40905201306j4ef96cafl8ac02736dbdf7e5@mail.gmail.com>
	<1242856782.16901.203.camel@pasglop>
	<20090520.154104.48737237.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 21 May 2009 08:49:41 +1000
Message-Id: <1242859781.16901.216.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, thunderbird2k@gmail.com, John.Linn@xilinx.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-05-20 at 15:41 -0700, David Miller wrote:
> This is exactly what sparc64 does as well, I took the powerpc code. :)
> 
> It also avoids a bunch of bugs that get unearthed as a result of
> scanning the entire hierarchy with PCI config access "pokes".  Some
> PCI controllers hang when certain PCI config space addresses are
> accessed, meanwhile some hypervisor versions don't generate the bus
> timeout exception properly on PCI config accesses to nonexisting
> devices, the list is endless.
> 
> And all of that went away when I imported the ppc64 code to do
> this using the OF device tree.
> 
> So if you put this in a common place, let's consolidate the differences
> accumulated in the sparc64 code so I can use it too :-)

Allright, I'll give that a go asap, maybe tomorrow.

Cheers,
Ben.
