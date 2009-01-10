Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 83DC3DDF1F
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Jan 2009 10:33:10 +1100 (EST)
Subject: Re: [PATCH RFC v5] net: add PCINet driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ira Snyder <iws@ovro.caltech.edu>
In-Reply-To: <20090108215127.GA28935@ovro.caltech.edu>
References: <20090107195052.GA24981@ovro.caltech.edu>
	<20090108.111610.132149837.davem@davemloft.net>
	<20090108192716.GA19863@ovro.caltech.edu>
	<20090108215127.GA28935@ovro.caltech.edu>
Content-Type: text/plain
Date: Sun, 11 Jan 2009 10:32:35 +1100
Message-Id: <1231630355.2142.92.camel@pasglop>
Mime-Version: 1.0
Cc: arnd@arndb.de, netdev@vger.kernel.org,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	shemminger@vyatta.com, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-01-08 at 13:51 -0800, Ira Snyder wrote:
> The guests (PowerPC computers running Linux) are PCI cards in the host
> system (an Intel Pentium3-M system). The guest computers can access all
> of the host's memory. The guests provide a 1MB (movable) window into
> their memory.
> 
> The PowerPC computers also have a DMA controller, which I've used to get
> better throughput from my driver. I have a way to create interrupts to
> both the host and guest systems.

That looks -very- similar to the PCI driver for CAB and Cell triblades
that was, I think, submitted a while ago. Arnd what's the status with
that driver ?

Cheers,
Ben.
