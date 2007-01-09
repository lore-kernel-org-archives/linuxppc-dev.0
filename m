Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B9DA4DDDFF
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 10:05:43 +1100 (EST)
In-Reply-To: <1168382543.22458.318.camel@localhost.localdomain>
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
	<1168380289.22458.313.camel@localhost.localdomain>
	<c191ad29e827e1e26464cde281f88ef5@kernel.crashing.org>
	<1168382543.22458.318.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7f47f2d575370ac73003b97fe9c5372b@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: EMAC OF binding....
Date: Wed, 10 Jan 2007 00:05:42 +0100
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
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

> I will not describe every single weird clock control or other magic 
> DCRs
> in the device-tree. That is simply over-bloat.

Sure, I know what you mean.

> We don't describe the U3
> clock control or PM registers on js2x's for example,

"reg" = f8000000 01000000

yes we do.  Not the individual regs sure, but we don't
do that for anything else either.

> nor do we describe
> the various individual registers controlling the HT link...

I never said you should describe the individual regs.
I'm saying the regs should be described somewhere, and
they can't be in the enet devices, so they'll have to
be elsewhere.

Oh well, I'm sure you'll figure it out,


Segher
