Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7324BDDDFF
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 18:26:24 +1100 (EST)
Subject: Re: [PATCH] [POWERPC] Add machine initcall macros
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1196493067.17582.7.camel@concordia>
References: <20071201002437.22923.31304.stgit@trillian.secretlab.ca>
	<1196493067.17582.7.camel@concordia>
Content-Type: text/plain
Date: Sat, 01 Dec 2007 18:26:01 +1100
Message-Id: <1196493961.13230.134.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, olof@lixom.net
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 2007-12-01 at 18:11 +1100, Michael Ellerman wrote:
> I can't think at the moment, it's Saturday, but is there some way we
> could just make it a wrapper macro, so we don't need to redefine - and
> keep in sync - all the different init call types?
> 
> So the usage would look something like:
> 
> arch_initcall(machine_initcall(foo, bar));
> 
> or 
> 
> machine_initcall(foo, arch_initcall(bar));

Not really. I'd like to turn that into magic ELF sections ultimately, in
which case your trick above wouldn't work... besides, it's clumsy :-)

Ben.
