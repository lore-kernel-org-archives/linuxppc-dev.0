Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4107767C06
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 13:45:46 +1000 (EST)
Subject: Re: [PATCH 1/3] Adapt ipic driver to new host_ops interface, add
	set_irq_type to set IRQ sense
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <FBC2DEDA-6D07-4FD6-93FD-E1D37145AB7F@kernel.crashing.org>
References: <20060823203928.3c5f9509.kim.phillips@freescale.com>
	<FBC2DEDA-6D07-4FD6-93FD-E1D37145AB7F@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 13:45:25 +1000
Message-Id: <1156391125.8433.166.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-08-23 at 20:58 -0500, Kumar Gala wrote:
> On Aug 23, 2006, at 8:39 PM, Kim Phillips wrote:
> 
> > This converts ipic code to Benh's IRQ mods.  For the IPIC, IRQ  
> > sense values in the device tree equal those in include/linux/irq.h;  
> > that's 8 for low assertion (most internal IRQs on mpc83xx), and 2  
> > for high-to-low change.
> >
> > Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> > Signed-off-by: Li Yang <leoli@freescale.com>
> 
> This breaks the arch/ppc build of 83xx, can we clone ipic as it  
> stands move that over to arch/ppc and apply your changes on top of that.

Yup, we should do that, like I did for i8259, at least until
arch/powerpc 83xx is in good enough shape that the arch/ppc one can be
dropped completely.

Ben.
 
