Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0BACBDDE05
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Dec 2007 18:07:24 +1100 (EST)
Subject: Re: [PATCH 11/25] powerpc: 4xx PLB to PCI Express support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200712070802.01126.sr@denx.de>
References: <20071206080120.B47DBDDF15@ozlabs.org>
	<200712061026.57215.sr@denx.de> <1196979686.6599.1.camel@pasglop>
	<200712070802.01126.sr@denx.de>
Content-Type: text/plain
Date: Sun, 09 Dec 2007 18:07:08 +1100
Message-Id: <1197184029.6572.19.camel@pasglop>
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


On Fri, 2007-12-07 at 08:02 +0100, Stefan Roese wrote:
> 
> > Ah... crap ! Do you think we should put that in the boot wrapper and
> > fixup the device-tree or should we put it in the PCIe code proper ?
> 
> How about this: We change the compatible node to "plb-pciex-440spe" 
> (without "A" and "B) and make a PVR runtime detection in the 4xx-pci
> driver.
> 
> What do you think? Should I prepare a patch for this?

I suppose that's the best way though we should do the detection the
other way around form the old code, that is detect rev A explicitely and
consider everything else rev B (just in case some new rev ever
appears..)

Yes, I would appreciate a patch, thanks.

Ben.
