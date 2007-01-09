Return-Path: <benh@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5158ADDE21
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 09:04:55 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp04.au.ibm.com (8.13.8/8.13.5) with ESMTP id l09MIflI342918
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 09:18:41 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by sd0208e0.au.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	l09M8MAr257872
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 09:08:22 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l09M4rhp026295
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 09:04:53 +1100
Subject: Re: EMAC OF binding....
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <e4d627ebdd8e678a0441bc0649714de8@kernel.crashing.org>
References: <OF7EF2F643.75F7008B-ON8625725D.00157658-8625725D.00167CB4@au1.ibm.com>
	<1168236558.22458.187.camel@localhost.localdomain>
	<8ee3d13b73a511a785ac4744c268943e@kernel.crashing.org>
	<1168288352.22458.198.camel@localhost.localdomain>
	<5f992368c65d3d53003b0e9f2955ae79@kernel.crashing.org>
	<1168296460.22458.232.camel@localhost.localdomain>
	<27d6554d600437ed39853784c0cf96fd@kernel.crashing.org>
	<1168302607.22458.242.camel@localhost.localdomain>
	<9a44c3bbc4ab67921f784f16991889bd@kernel.crashing.org>
	<1168379157.22458.307.camel@localhost.localdomain>
	<e4d627ebdd8e678a0441bc0649714de8@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 10 Jan 2007 09:04:48 +1100
Message-Id: <1168380289.22458.313.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Christian Rund <Christian.Rund@de.ibm.com>,
	Hartmut Penner <HPENNER@de.ibm.com>, Murali N Iyer <mniyer@us.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-01-09 at 22:57 +0100, Segher Boessenkool wrote:
> > Well, we use that method for most things,for example, the emac has
> > phandles to the zmii/rgmii/etc... for that specific case however, I
> > still prefer a cell index.
> 
> How about you put both in the device tree, and the kernel
> can use whatever it wants -- best of both worlds :-)

I don't see the need of having some weird "soc" node that doesn't quite
mean anything (especially on axon) that has phandles to every sub device
in there :-)

I really don't see the interest in your approach but I may have missed
something.

On those ASICs, every device almost needs to know what is it's "cell
index" because of little details here or there. I really see that as an
attribute of the device and thus should be a property of the node.
 
Ben.
