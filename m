Return-Path: <benh@kernel.crashing.org>
Subject: Re: IRQs in i2c-mpc.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910711110734m7d36a235t72f5112e59cbe0d5@mail.gmail.com>
References: <9e4733910711101144r3f8745dbs572aefa8658e1312@mail.gmail.com>
	<3DBBAC12-579B-4C1F-9C9E-D085FB22B687@kernel.crashing.org>
	<9e4733910711101516n64870e40rbd1fcbe3d123fcc3@mail.gmail.com>
	<A4797E92-9FCF-484A-B6AA-9385913AD465@kernel.crashing.org>
	<9e4733910711101544v178e29cer4e53577c011e89f7@mail.gmail.com>
	<1194762471.21340.39.camel@pasglop>
	<9e4733910711110734m7d36a235t72f5112e59cbe0d5@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 12 Nov 2007 07:44:49 +1100
Message-Id: <1194813889.6510.11.camel@pasglop>
Mime-Version: 1.0
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Is the only error return from irq_of_parse_and_map() NO_IRQ? or can we
> get standard negative returns? I started tracing out the returns from
> irq_of_parse_and_map() but there are a lot of them.

NP_IRQ is the only error return.

Ben.
