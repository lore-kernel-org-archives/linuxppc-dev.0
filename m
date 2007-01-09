Return-Path: <benh@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4685CDDDEA
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 08:46:12 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp04.au.ibm.com (8.13.8/8.13.5) with ESMTP id l09LxwXq283782
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 08:59:58 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by sd0208e0.au.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	l09LnTvv149704
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 08:49:34 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l09Lk0ZY016823
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 08:46:00 +1100
Subject: Re: EMAC OF binding....
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <9a44c3bbc4ab67921f784f16991889bd@kernel.crashing.org>
References: <OF7EF2F643.75F7008B-ON8625725D.00157658-8625725D.00167CB4@au1.ibm.com>
	<1168236558.22458.187.camel@localhost.localdomain>
	<8ee3d13b73a511a785ac4744c268943e@kernel.crashing.org>
	<1168288352.22458.198.camel@localhost.localdomain>
	<5f992368c65d3d53003b0e9f2955ae79@kernel.crashing.org>
	<1168296460.22458.232.camel@localhost.localdomain>
	<27d6554d600437ed39853784c0cf96fd@kernel.crashing.org>
	<1168302607.22458.242.camel@localhost.localdomain>
	<9a44c3bbc4ab67921f784f16991889bd@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 10 Jan 2007 08:45:57 +1100
Message-Id: <1168379157.22458.307.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Christian Rund <Christian.Rund@de.ibm.com>,
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


> You give the phandle of your emac node as argument, that
> works just fine with what I proposed too (the SoC PM node
> knows the phandles of the emac's).  I think your way isn't
> all that clean architecturally and can easily lead to
> problems later on; the emac shouldn't have to know *anything*
> about the structure of the SoC.
> 
> But feel free to do what you want, it's certainly not
> a *huge* problem ;-)

Well, we use that method for most things,for example, the emac has
phandles to the zmii/rgmii/etc... for that specific case however, I
still prefer a cell index.

Ben.
