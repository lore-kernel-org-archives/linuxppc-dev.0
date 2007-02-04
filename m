Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CDC85DDE47
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Feb 2007 15:41:46 +1100 (EST)
Subject: Re: EMAC device-tree binding (#2)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <70A55501-3409-460B-8EBA-B880F3EA9A5F@kernel.crashing.org>
References: <1170118707.26655.299.camel@localhost.localdomain>
	<70A55501-3409-460B-8EBA-B880F3EA9A5F@kernel.crashing.org>
Content-Type: text/plain
Date: Sun, 04 Feb 2007 15:41:48 +1100
Message-Id: <1170564108.2620.21.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-02-02 at 07:50 +0100, Segher Boessenkool wrote:
> >  - phy-mode          : 1 cell, Mode of operations of the PHY  
> > interface:
> >                          #define PHY_MODE_NA    0
> >                          #define PHY_MODE_MII   1
> >                          #define PHY_MODE_RMII  2
> >                          #define PHY_MODE_SMII  3
> >                          #define PHY_MODE_RGMII 4
> >                          #define PHY_MODE_TBI   5
> >                          #define PHY_MODE_GMII  6
> >                          #define PHY_MODE_RTBI  7
> >                          #define PHY_MODE_SGMII 8
> >                        For axon, it is PHY_MODE_RGMII
> 
> Just use a string here...  phy-mode = "rgmii" etc.

Good point. I'll change that.

> > * In the McMAL node
> >
> >  - name               : "mcmal"
> >  - device_type        : "mcmal-dma"
> 
> "dma-controller" instead?

Yeah, good idea.

> >  - device_type        : "emac-zmii"
> 
> Similar.

rgmii and zmii are "weird"... they aren't DMA controllers. They are EMAC
specific link interfaces, I'm not sure how to call them.

Ben.
