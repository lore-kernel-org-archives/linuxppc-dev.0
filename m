Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AC221B70AE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Oct 2010 12:26:31 +1100 (EST)
Subject: Re: MSI-X vector allocation failure in upstream kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anirban Chakraborty <anirban.chakraborty@qlogic.com>
In-Reply-To: <9101728E-3FFC-457E-AF5B-87B2037FEC32@qlogic.com>
References: <9101728E-3FFC-457E-AF5B-87B2037FEC32@qlogic.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 08 Oct 2010 12:26:12 +1100
Message-ID: <1286501172.2463.395.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Michael Ellerman <michaele@au1.ibm.com>,
	Ameen Rahman <ameen.rahman@qlogic.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-10-05 at 10:18 -0700, Anirban Chakraborty wrote:
> Hi All,
> 
> I am trying to test qlcnic driver (for 10Gb QLogic network adapter) on a Power 6 system 
> (IBM P 520, System type 8203) with upstream kernel and I do see that the kernel is 
> not able to allocate any MSI-X vectors. The driver requests for 4 vectors in pci_enable_msix,
> which returns 2. The driver again attempts, this time for 2 vectors but the kernel can't allocate 
> and it returns a value of 0xfffffffd. I upgraded the system FW to 01EL350 (from 01EL340)
>  just to make sure if MSI-X is enabled in the system. Is there anything that I am missing? 
> 
> Any pointers will be highly appreciated.

I think the people who can help you at the moment are on vacation :-)

Can you make sure kernel debug is enabled and you have "debug" on the
kernel command line, and send the full dmesg log of what's going on ?

Hopefully, Michael will be back next week and will be able to have a
look at it.

Cheers,
Ben.
