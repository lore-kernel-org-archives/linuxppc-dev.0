Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 85691DDEBF
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jun 2007 17:09:44 +1000 (EST)
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Randy Vinson <rvinson@mvista.com>
In-Reply-To: <466492DC.6050708@mvista.com>
References: <1180720112.14219.62.camel@ld0161-tx32>
	<dfc15991e31bfc09389461dc443acd7c@kernel.crashing.org>
	<1180734314.5674.49.camel@rhino>
	<4fb92a9dfccf515bdc1522d08f10f823@kernel.crashing.org>
	<20070602085359.GA10333@iram.es>
	<3ebd6ca6877ea74925f066ff96ac81db@kernel.crashing.org>
	<20070602195308.GA21618@iram.es>
	<12ad593bd17f769e44f05bc24eac4d0a@kernel.crashing.org>
	<1180828907.14025.37.camel@localhost.localdomain>
	<28e0600256815f93db45b2f4eb2d9df5@kernel.crashing.org>
	<20070603083339.GB2157@iram.es>
	<02DC2E36-86B1-4458-BB0C-13CF79AC1D11@freescale.com>
	<466492DC.6050708@mvista.com>
Content-Type: text/plain
Date: Wed, 06 Jun 2007 17:09:23 +1000
Message-Id: <1181113764.31677.242.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-06-04 at 15:31 -0700, Randy Vinson wrote:
> Actually, that's not strictly true. If a card containing a P2P bridge
> is
> installed into PCI slot 4, the i8259 will end up on a bus that is not
> numbered bus 1. I've often wondered how something like that is handled
> in the DTS.

The bus number shouldn't matter as long as low IO cycles are properly
forwarded to it.

Ben.
