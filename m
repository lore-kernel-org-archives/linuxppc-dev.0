Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D906D67C51
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 08:39:19 +1100 (EST)
Subject: Re: Booting without Uboot on 8548E
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andy Fleming <afleming@freescale.com>
In-Reply-To: <C508D5D4-125D-47FD-81D2-2DE6545A240F@freescale.com>
References: <BAY102-F634C51A5AEEB25090456BA9FD0@phx.gbl>
	<C508D5D4-125D-47FD-81D2-2DE6545A240F@freescale.com>
Content-Type: text/plain
Date: Tue, 07 Nov 2006 08:38:10 +1100
Message-Id: <1162849091.28571.348.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: M Ptich <ptich@hotmail.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> But moving to arch/powerpc (while a good idea) is not going to solve  
> your problems.  There are bound to be a large number of things the  
> kernel expects to have done for it by the firmware.  In arch/powerpc,  
> the 8548 kernel expects PCI to be set up, for instance (We plan to  
> fix that, but it involves porting some code that only exists in arch/ 
> ppc).

I hope you don't mean porting pci-auto over :)

While It was good to have back then, we should really fix out PCI layer
to properly assign unassigned devices itself.

There is much work to do to cleanup ppc32, ppc64 and core PCI so they
can deal with all the various setups around, but it's probably a
worthwhile goal.

Ben.
