Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 053A5DDEC6
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 17:33:33 +1100 (EST)
Subject: Re: Bamboo PCI interrupt issues
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200803040715.22301.sr@denx.de>
References: <1204588953.7921.13.camel@basalt>
	<20080303213718.12291eee@zod.rchland.ibm.com>
	<200803040715.22301.sr@denx.de>
Content-Type: text/plain
Date: Tue, 04 Mar 2008 17:33:04 +1100
Message-Id: <1204612384.21545.50.camel@pasglop>
Mime-Version: 1.0
Cc: kvm-ppc-devel <kvm-ppc-devel@lists.sourceforge.net>,
	linuxppc-dev@ozlabs.org, Hollis Blanchard <hollisb@us.ibm.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-03-04 at 07:15 +0100, Stefan Roese wrote:
> 
> Using '8' is correct. PCI interrupts are *always* level sensitive and
> active 
> low.

Unless you use one of those strange bridges that stick not gates on the
PCI IRQ inputs :-) But I don't think that's the case on the 440EP.

Ben.
