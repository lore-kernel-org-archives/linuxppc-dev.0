Return-Path: <r61911@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
 [65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 07314B6F94
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2011 15:27:11 +1100 (EST)
From: Zang Roy-R61911 <r61911@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, Kumar Gala
 <galak@kernel.crashing.org>
Subject: RE: [PATCH] powerpc/p1023: set IRQ[4:6, 11] to high level sensitive
 for PCIe
Date: Wed, 16 Nov 2011 04:27:01 +0000
Message-ID: <2239AC579C7D3646A720227A37E0268121EBED@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1320654778-3294-1-git-send-email-tie-fei.zang@freescale.com>
 <45E28F47-CC83-4059-959F-E890049F416B@kernel.crashing.org>
 <4EC2E42B.1090600@freescale.com>
In-Reply-To: <4EC2E42B.1090600@freescale.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Wednesday, November 16, 2011 6:14 AM
> To: Kumar Gala
> Cc: Zang Roy-R61911; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH] powerpc/p1023: set IRQ[4:6, 11] to high level
> sensitive for PCIe
>=20
> On 11/15/2011 03:51 PM, Kumar Gala wrote:
> >
> > On Nov 7, 2011, at 2:32 AM, Roy Zang wrote:
> >
> > Should be setting ALL PCIe interrupts to '2'?  As I think in general
> > we say these PCIe are 'active high'.  The only reason I would think
> > we would NOT do this is if they are shared with some external device
> > that is 'active low'.  If so we should comment that somewhere (maybe
> > in the .dts, maybe just in the commit message).
>=20
> I'd assume the ones that are pinned out are pulled high on the board.
yes. The boards pulled up the shared IRQs. PCIe specification does not spec=
ify 'active low' or 'active high', but for PCI, the INTx is 'active low'.

> Active-low is normal, it's these non-pinned-out "external" interrupts
> that are pulled low inside the SoC that are weird.
I agree here. Do you want me to add something to point out the "weird" in t=
he commit message?
Thanks.
Roy
