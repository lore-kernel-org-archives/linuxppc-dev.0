Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 848A5DDDF7
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Dec 2007 18:28:15 +1100 (EST)
Subject: Re: [PATCH 19/19] [POWERPC] pci_controller->arch_data really is a
	struct device_node *
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20071207020542.577bbfe8.sfr@canb.auug.org.au>
References: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
	<20071207020542.577bbfe8.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Sun, 09 Dec 2007 18:27:51 +1100
Message-Id: <1197185271.6572.41.camel@pasglop>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-12-07 at 02:05 +1100, Stephen Rothwell wrote:
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---

Ah excellent, I had that on my to-do list for some time. However, we
should also rename it as I'm getting more and more pressure to put a
real void * arch_data in here for use by a specific PCI host bridge
implementation...

Cheers,
Ben.
