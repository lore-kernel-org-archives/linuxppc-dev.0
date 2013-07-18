Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 293022C0084
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jul 2013 08:03:05 +1000 (EST)
Message-ID: <1374184953.19894.525.camel@pasglop>
Subject: Re: Inbound PCI and Memory Corruption
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter LaDow <petela@gocougs.wsu.edu>
Date: Fri, 19 Jul 2013 08:02:33 +1000
In-Reply-To: <CAN8Q1EeKCTCB30N50iA8-QB=0aoNtS1U3nNLGVoz7sHG-Qg26A@mail.gmail.com>
References: <CAN8Q1EdnN9+kKGy+voF3=EyPfbHv04Emfz=uA6XKMJEAkvLpAA@mail.gmail.com>
 <CAN8Q1Ed9Lpg1Sog5tQODe+jqCRXBBH3d_UeR5usdc23CD7vwjg@mail.gmail.com>
 <1371945647.3944.106.camel@pasglop>
 <CAN8Q1EetHpVkWFmbDGCE-3J4H7oJm0zE66SAdJyvtDb7OBc-gg@mail.gmail.com>
 <1373492413.19894.29.camel@pasglop>
 <CAN8Q1EdVVw3ofg9O3o=WThsKpcfMBXe_C7JsSSx9DdRZULW17Q@mail.gmail.com>
 <CAN8Q1EeKCTCB30N50iA8-QB=0aoNtS1U3nNLGVoz7sHG-Qg26A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-07-18 at 14:30 -0700, Peter LaDow wrote:
> We are still stumped on this one, but during a review of the system
> setup one thing came up that we aren't sure about is the device tree
> and the DMA engine.
> 
> It does seem that for incoming PCI transactions the Freescale DMA
> engine is not used.  And in our device tree we have the DMA engine
> commented out.  That is, the "fsl,mpc8349-dma" and "fsl,elo-dma"
> compatible items are not present in the FDT.
> 
> I don't suppose this could be a problem?

I doubt it but somebody from FSL might be able to give a better answer.

I'm personally at a loss. It looks like you are doing everything
right from what I can tell.

That leaves us with some kind of oddball driver bug or a problem
with the low level configuration of the PCIe bridge or the chip
internal bus related to cache coherency maybe.

Ben.
