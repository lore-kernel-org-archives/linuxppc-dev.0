Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D0F3167BAD
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Nov 2006 20:19:46 +1100 (EST)
Subject: Re: Booting without Uboot on 8548E
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: M Ptich <ptich@hotmail.com>
In-Reply-To: <1162631621.28571.26.camel@localhost.localdomain>
References: <BAY102-F21BB220054F2541A7614E4A9FD0@phx.gbl>
	<1162631621.28571.26.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 04 Nov 2006 20:19:40 +1100
Message-Id: <1162631980.28571.30.camel@localhost.localdomain>
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


> > Slowly, we are finding that this list is not complete. For example, address 
> > calculation at the start of platform_init (r3 + ...) assumes that Kernel has 
> > been initially loaded at 0-base virtual address.
> 
> For which CPU core ? 6xx/7xx/7xxx/G2 cores don't assume such a thing,
> the kernel can be loaded anywhere as long as the virtual and physical
> addresses are the same.

I've checked and 85xx is some sort of BookE, so you'll have to wait for
the freescale folks here to help you..

(Note that it's unlikely that people will be motivated to help you
considering the rude tone of your initial email)

Ben.
