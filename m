Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CBE2C67B47
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Jun 2006 13:14:43 +1000 (EST)
Subject: Re: [PATCH 5/9 v3] Add the MPC8641 HPCN platform files.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@jdl.com>
In-Reply-To: <E1Frjen-0004Oz-Hz@jdl.com>
References: <E1Frjen-0004Oz-Hz@jdl.com>
Content-Type: text/plain
Date: Sun, 18 Jun 2006 13:14:29 +1000
Message-Id: <1150600470.23600.158.camel@localhost.localdomain>
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


> +/*
> + * Internal interrupts are all Level Sensitive, and Positive Polarity
> + */
> +
> +static u_char mpc86xx_hpcn_openpic_initsenses[] __initdata = {
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  0: Reserved */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  1: MCM */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  2: DDR DRAM */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  3: LBIU */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  4: DMA 0 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  5: DMA 1 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  6: DMA 2 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  7: DMA 3 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  8: PCIE1 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  9: PCIE2 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 10: Reserved */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 11: Reserved */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 12: DUART2 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 13: TSEC 1 Transmit */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 14: TSEC 1 Receive */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 15: TSEC 3 transmit */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 16: TSEC 3 receive */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 17: TSEC 3 error */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 18: TSEC 1 Receive/Transmit Error */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 19: TSEC 2 Transmit */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 20: TSEC 2 Receive */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 21: TSEC 4 transmit */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 22: TSEC 4 receive */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 23: TSEC 4 error */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 24: TSEC 2 Receive/Transmit Error */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 25: Unused */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 26: DUART1 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 27: I2C */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 28: Performance Monitor */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 29: Unused */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 30: Unused */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 31: Unused */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 32: SRIO error/write-port unit */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 33: SRIO outbound doorbell */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 34: SRIO inbound doorbell */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 35: Unused */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 36: Unused */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 37: SRIO outbound message unit 1 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 38: SRIO inbound message unit 1 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 39: SRIO outbound message unit 2 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 40: SRIO inbound message unit 2 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 41: Unused */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 42: Unused */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 43: Unused */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 44: Unused */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 45: Unused */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 46: Unused */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 47: Unused */
> +	0x0,						/* External  0: */
> +	0x0,						/* External  1: */
> +	0x0,						/* External  2: */
> +	0x0,						/* External  3: */
> +	0x0,						/* External  4: */
> +	0x0,						/* External  5: */
> +	0x0,						/* External  6: */
> +	0x0,						/* External  7: */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External  8: Pixis FPGA */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* External  9: ULI 8259 INTR Cascade */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 10: Quad ETH PHY */
> +	0x0,						/* External 11: */
> +	0x0,
> +	0x0,
> +	0x0,
> +	0x0,
> +};

So what I suggest you do with the above, rather than having this big
array in the kernel, is to have a property in the interrupt controller
node, let's call it "default-senses", which contains a cell for every
interrupt source with the default sense value.

The interrupt mapping code that I'm working on will allow individual
interrupts to carry their sense value through the device-tree, but it's
useful to have some sane defaults, either because you don't have a
device-tree entry for a given interrupt (oops, happens ...) or
because... you don't have my new code yet :)

I'm not too fan of the big table in the kernel however. I'd rather have
it in the device-tree.

I'm not forcing you here, do as you prefer, but if you decide to go
toward the "default-senses" property in the DT, then I think we should
add a couple of sections to my proposed patch to the
booting-without-of.txt file about interrupt that describes a set of
optional properties for interrupt controllers, and describe that there.

I'm toying with creating a "generic" create_interrupt_controller()
function in fact that takes a device-node and would instanciate known
interrupt controller types (i8259, OpenPIC, for now, maybe more later)
entire based on device-tree properties (big-endian, maybe that one for
default sense codes, etc...).

Cheers,
Ben.
