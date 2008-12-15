Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E0A25DDF70
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 08:05:14 +1100 (EST)
Subject: Re: [PATCH 11/16] powerpc/mm: Add SMP support to no-hash TLB
	handling v3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <C0519630-66EF-4860-A27E-15CC749D98DC@freescale.com>
References: <20081215054554.E883EDDF9D@ozlabs.org>
	<B3FDD472-0720-4454-9329-5A1C8A9BF84A@freescale.com>
	<1229373978.26324.120.camel@pasglop>
	<C0519630-66EF-4860-A27E-15CC749D98DC@freescale.com>
Content-Type: text/plain
Date: Tue, 16 Dec 2008 08:03:04 +1100
Message-Id: <1229374984.26324.125.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > The whole thing. Not totally clear, you have a better name ? Some CPUs
> > want a lock on sync and some on ivax, I plan to lock the whole  
> > sequence.
> 
> MMU_FTR_TLBIVAX_OR_SYNC_NEED_LOCK ?

Which completely blows away the nice tab'ing :-)

MMU_FTR_LOCK_BCAST_TLB_OPS ?

> Its probably a good idea to have a clear definition of what each of  
> these flags means in the commit message.

No, I'd rather have that in a comment in the code.

Cheers,
Ben.
