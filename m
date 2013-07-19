Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2B5EA2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jul 2013 03:44:42 +1000 (EST)
Date: Fri, 19 Jul 2013 12:44:33 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: Inbound PCI and Memory Corruption
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <CAN8Q1EdnN9+kKGy+voF3=EyPfbHv04Emfz=uA6XKMJEAkvLpAA@mail.gmail.com>
 <CAN8Q1Ed9Lpg1Sog5tQODe+jqCRXBBH3d_UeR5usdc23CD7vwjg@mail.gmail.com>
 <1371945647.3944.106.camel@pasglop>
 <CAN8Q1EetHpVkWFmbDGCE-3J4H7oJm0zE66SAdJyvtDb7OBc-gg@mail.gmail.com>
 <1373492413.19894.29.camel@pasglop>
 <CAN8Q1EdVVw3ofg9O3o=WThsKpcfMBXe_C7JsSSx9DdRZULW17Q@mail.gmail.com>
 <CAN8Q1EeKCTCB30N50iA8-QB=0aoNtS1U3nNLGVoz7sHG-Qg26A@mail.gmail.com>
 <1374184953.19894.525.camel@pasglop>
In-Reply-To: <1374184953.19894.525.camel@pasglop> (from
 benh@kernel.crashing.org on Thu Jul 18 17:02:33 2013)
Message-ID: <1374255873.5357.20@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Peter LaDow <petela@gocougs.wsu.edu>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/18/2013 05:02:33 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2013-07-18 at 14:30 -0700, Peter LaDow wrote:
> > We are still stumped on this one, but during a review of the system
> > setup one thing came up that we aren't sure about is the device tree
> > and the DMA engine.
> >
> > It does seem that for incoming PCI transactions the Freescale DMA
> > engine is not used.  And in our device tree we have the DMA engine
> > commented out.  That is, the "fsl,mpc8349-dma" and "fsl,elo-dma"
> > compatible items are not present in the FDT.
> >
> > I don't suppose this could be a problem?
>=20
> I doubt it but somebody from FSL might be able to give a better =20
> answer.

The DMA engine is not related to inbound PCI transactions.

-Scott=
