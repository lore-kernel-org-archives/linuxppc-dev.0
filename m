Return-Path: <B16395@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 473492C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2013 04:10:03 +1000 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, Yoder Stuart-B08248
 <B08248@freescale.com>
Subject: RE: pci overmapping
Date: Thu, 2 May 2013 18:09:53 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D4D3E5A@039-SN2MPN1-011.039d.mgd.msft.net>
References: <9F6FE96B71CF29479FF1CDC8046E15035C8E18@039-SN1MPN1-002.039d.mgd.msft.net>
 <1367514839.24411.12@snotra>
In-Reply-To: <1367514839.24411.12@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Thursday, May 02, 2013 10:44 PM
> To: Yoder Stuart-B08248
> Cc: galak@kernel.crashing.org; Sethi Varun-B16395; linuxppc-
> dev@lists.ozlabs.org
> Subject: Re: pci overmapping
>=20
> On 05/02/2013 12:05:42 PM, Yoder Stuart-B08248 wrote:
> > Kumar,
> >
> > In fsl_pci.c there is a change you made a while back:
> >   "powerpc/fsl: Setup PCI inbound window based on actual amount of
> > memory"
> >
> > ...and there is this comment in the code:
> >
> >     /* PCIe can overmap inbound & outbound since RX & TX are separated
> > */
> >     if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
> >
> > You are implying that PCIe can overmap and PCI can't.  Why is
> > that?   (I'm assuming that 'overmap' means that inbound window
> > can extend beyond the end of ram.)
>=20
> Shouldn't the concern be whether we're overlapping outbound, not merely
> whether we go beyond the end of RAM?
>=20
> And couldn't inbound/outbound overlap be an issue even on PCIe, if
> there's a PCI bridge underneath it?
I believe that the overlap problem would be avoided in case of 36 bit physi=
cal support (outbound window address would be high order 36 bit value), rig=
ht?

-Varun
