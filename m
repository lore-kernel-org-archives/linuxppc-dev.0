Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] General CHRP/MPC5K2 platform support patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas DET <nd@bplan-gmbh.de>
In-Reply-To: <45409760.7030902@bplan-gmbh.de>
References: <453FB582.20802@bplan-gmbh.de>
	<1161816783.22582.132.camel@localhost.localdomain>
	<45409760.7030902@bplan-gmbh.de>
Content-Type: text/plain
Date: Thu, 26 Oct 2006 22:49:24 +1000
Message-Id: <1161866964.27827.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: akpm@osdl.org, Sylvain Munaut <tnt@246tNt.com>, sl@bplan-gmbh.de,
	linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org, sha@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> rent patch, I know do:
> mpc52xx_irqhost = irq_alloc_host(IRQ_HOST_MAP_LINEAR, NR_IRQS, 
> &mpc52xx_irqhost_ops, -1);
> 
> Which should be ok.

NR_IRQ, it's a bit violent :) It's also the max number of virtual IRQs
and thus has nothing to do with your HW numbers. Use the max number of
HW IRQs here.

Ben.
