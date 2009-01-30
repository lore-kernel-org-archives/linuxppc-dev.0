Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5D63EDE0B2
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 13:09:06 +1100 (EST)
Subject: Re: Broken PCI on Sequoia
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20090130001842.GB3943@zod.rchland.ibm.com>
References: <alpine.LRH.2.00.0901291819440.22142@vixen.sonytel.be>
	<1233267061.18767.5.camel@pasglop>
	<20090130001842.GB3943@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Fri, 30 Jan 2009 13:08:53 +1100
Message-Id: <1233281333.18767.15.camel@pasglop>
Mime-Version: 1.0
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Yeah.  In fact, I think you have that bug in almost every board.  You only
> updated Bamboo and Canyonlands with the initial patch and the changelog
> says "other boards can be updated separately."  Nobody did that.  So not
> so weird after all.

I still don't see off hand what's wrong in the code..

Geert, any chance you can sprinkle printk's in
ppc4xx_configure_pci_PMMs() ? I'd like to see the arguments to the
various calls to ppc4xx_setup_one_pci_PMM(), and the value of
hose->pci_mem_offset and hose->isa_mem_phys & size.

Cheers,
Ben.
