Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B7D9CDDFE9
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 23:40:25 +1000 (EST)
Subject: Re: [RFC] Device tree for new desktop platform in arch/powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20070622131201.313400@gmx.net>
References: <20070618185715.321010@gmx.net>
	<1182429406.24740.6.camel@localhost.localdomain>
	<20070621132059.25900@gmx.net>
	<1182468169.24740.15.camel@localhost.localdomain>
	<20070622131201.313400@gmx.net>
Content-Type: text/plain
Date: Fri, 22 Jun 2007 23:40:15 +1000
Message-Id: <1182519615.24740.60.camel@localhost.localdomain>
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

On Fri, 2007-06-22 at 15:12 +0200, Gerhard Pircher wrote:
> I would like to have PCI nodes only for the PCI host and PCI2ISA
> bridge.
> The interrupt mapping of the INT# lines can be configured within
> U-boot,
> thus I would avoid to specify it somewhere in the device tree, if it
> isn't
> really necessary.

You still need to provide the IRQ mapping for the PCI slots, but you can
do that from the interrupt-map property of the PCI host bridge node.

Ben.
