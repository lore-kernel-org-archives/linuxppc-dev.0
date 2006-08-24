Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7378567BC9
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 11:58:45 +1000 (EST)
In-Reply-To: <20060823203928.3c5f9509.kim.phillips@freescale.com>
References: <20060823203928.3c5f9509.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FBC2DEDA-6D07-4FD6-93FD-E1D37145AB7F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] Adapt ipic driver to new host_ops interface,
	add set_irq_type to set IRQ sense
Date: Wed, 23 Aug 2006 20:58:37 -0500
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 23, 2006, at 8:39 PM, Kim Phillips wrote:

> This converts ipic code to Benh's IRQ mods.  For the IPIC, IRQ  
> sense values in the device tree equal those in include/linux/irq.h;  
> that's 8 for low assertion (most internal IRQs on mpc83xx), and 2  
> for high-to-low change.
>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>

This breaks the arch/ppc build of 83xx, can we clone ipic as it  
stands move that over to arch/ppc and apply your changes on top of that.

- kumar
