Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C0647DDE02
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 10:44:01 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp05.au.ibm.com (8.13.8/8.13.6) with ESMTP id l0ABjcnL5058752
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 10:45:39 -0100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by sd0208e0.au.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	l09NlHwD191448
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 10:47:22 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l09NhmNq022024
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 10:43:49 +1100
Date: Wed, 10 Jan 2007 09:41:07 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: EMAC OF binding....
Message-ID: <20070109224107.GA14563@localhost.localdomain>
References: <1168288352.22458.198.camel@localhost.localdomain>
	<5f992368c65d3d53003b0e9f2955ae79@kernel.crashing.org>
	<1168296460.22458.232.camel@localhost.localdomain>
	<27d6554d600437ed39853784c0cf96fd@kernel.crashing.org>
	<1168302607.22458.242.camel@localhost.localdomain>
	<9a44c3bbc4ab67921f784f16991889bd@kernel.crashing.org>
	<1168379157.22458.307.camel@localhost.localdomain>
	<e4d627ebdd8e678a0441bc0649714de8@kernel.crashing.org>
	<1168380289.22458.313.camel@localhost.localdomain>
	<c191ad29e827e1e26464cde281f88ef5@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c191ad29e827e1e26464cde281f88ef5@kernel.crashing.org>
Cc: Christian Rund <Christian.Rund@de.ibm.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Murali N Iyer <mniyer@us.ibm.com>, Hartmut Penner <HPENNER@de.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 09, 2007 at 11:17:07PM +0100, Segher Boessenkool wrote:
> > I don't see the need of having some weird "soc" node that doesn't quite
> > mean anything (especially on axon) that has phandles to every sub 
> > device
> > in there :-)
> 
> Well simply, if I understood you correctly, you have some
> register where some bits control emac #0 and some control
> emac #1.  This register can't belong to either of those
> devices because it can't belong to both, so it has to
> belong to some "control" / "power management" / whatever
> device.

I believe there are also some cases where you need to put the index
value itself into a field of some global control register.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
