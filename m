Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 12A9EDDEDB
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 19:01:55 +1100 (EST)
Subject: Re: [PATCH 24/24] powerpc: Base support for 440SPe "Katmai" eval board
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20071130061209.497F3DE03A@ozlabs.org>
References: <20071130061209.497F3DE03A@ozlabs.org>
Content-Type: text/plain
Date: Fri, 30 Nov 2007 18:59:55 +1100
Message-Id: <1196409595.13230.81.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-11-30 at 17:11 +1100, Benjamin Herrenschmidt wrote:
> This adds base support for the Katmai board, including PCI-X and
> PCI-Express (but no RTC, nvram, etc... yet).
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> As for Taishan, the bootwrapper code can be simplified. In fact,
> we probably don't need to probe clocks & memsize off the chip and
> just trust what uboot tells us.

This misses a select CONFIG_PPC4xx_PCI_EXPRESS in Kconfig, I added
that thing at the last minute and forgot to refresh the Katmai patch.

Without it, PCIe will not be probed.

Cheers,
Ben.
