Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 16374B7C7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Feb 2010 11:22:46 +1100 (EST)
Date: Wed, 17 Feb 2010 16:22:59 -0800 (PST)
Message-Id: <20100217.162259.91779007.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [RFC PATCH] PCI-E broken on PPC (regression)
From: David Miller <davem@davemloft.net>
In-Reply-To: <1264558256.3601.153.camel@pasglop>
References: <20100125123849.111fa2d1@jbarnes-piketon>
	<20100125175025.4c74f412@jbarnes-piketon>
	<1264558256.3601.153.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-pci@vger.kernel.org, fubar@us.ibm.com, jbarnes@virtuousgeek.org,
	ron.mercer@qlogic.com, kaneshige.kenji@jp.fujitsu.com,
	linuxppc-dev@lists.ozlabs.org, leitao@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 27 Jan 2010 13:10:56 +1100

> I'll try do make ppc catch up with some of that see how it goes.

FWIW I'm taking care of syncing up sparc in this area
right now.

I just noticed the ->dma_mask assignment got moved as well.

Really, any change made to drivers/pci/probe.c is going to
require powerpc and sparc changes these days.

We should and will commonize our OpenFirmware PCI device probing code
under driver/pci but until that happens a real effort needs to be put
in place to at least ping Benjamin and myself when changes are going
in to drivers/pci/probe.c

Thanks.
