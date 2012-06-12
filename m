Return-Path: <B38951@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 028AEB6FB4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2012 12:27:54 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 0/6] Description for PCI patches using platform driver
Date: Tue, 12 Jun 2012 02:27:47 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01A09756@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1339148527-16911-1-git-send-email-B38951@freescale.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D03D71F38@039-SN2MPN1-022.039d.mgd.msft.net>
 <412C8208B4A0464FA894C5F0C278CD5D01A0921B@039-SN1MPN1-002.039d.mgd.msft.net>
 <4FD61215.8030608@freescale.com>
In-Reply-To: <4FD61215.8030608@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Li Yang-R58472 <r58472@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Bhushan Bharat-R65777 <R65777@freescale.com>
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
> Sent: Monday, June 11, 2012 11:43 PM
> To: Jia Hongtao-B38951
> Cc: Bhushan Bharat-R65777; linuxppc-dev@lists.ozlabs.org;
> galak@kernel.crashing.org; Li Yang-R58472; benh@kernel.crashing.org; Wood
> Scott-B07421
> Subject: Re: [PATCH 0/6] Description for PCI patches using platform
> driver
>=20
> On 06/10/2012 09:33 PM, Jia Hongtao-B38951 wrote:
> >> -----Original Message-----
> >> From: Bhushan Bharat-R65777
> >> Sent: Friday, June 08, 2012 6:47 PM
> >> To: Jia Hongtao-B38951; linuxppc-dev@lists.ozlabs.org;
> >> galak@kernel.crashing.org
> >> Cc: Li Yang-R58472; benh@kernel.crashing.org; Wood Scott-B07421
> >> Subject: RE: [PATCH 0/6] Description for PCI patches using platform
> >> driver
> >>
> >>
> >>> -----Original Message-----
> >>> From: Jia Hongtao-B38951
> >>> Sent: Friday, June 08, 2012 3:12 PM
> >>> To: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org
> >>> Cc: Li Yang-R58472; benh@kernel.crashing.org; Wood Scott-B07421;
> >> Bhushan Bharat-
> >>> R65777; Jia Hongtao-B38951
> >>> Subject: [PATCH 0/6] Description for PCI patches using platform
> driver
> >>>
> >>> This series of patches are to unify pci initialization code and add
> PM
> >> support
> >>> for all 85xx/86xx powerpc boards. But two side effects are introduced
> >> by this
> >>> mechanism which listed below:
> >>>
> >>> 1. of_platform_bus_probe() will be called twice but in some cases
> >> duplication
> >>>    warning occured. We fix this in [PATCH 5/6].
> >>>
> >>> 2. Edac driver failed to register pci nodes as platform devices. We
> fix
> >> this
> >>>    in [PATCH 6/6].
> >>
> >> With these patches will not the SWIOTLB will not be initialized even
> if
> >> PCI/PCIe demanded?
> >>
> >> Thanks
> >> -Bharat
> >>
> >
> > These patches still have the swiotlb init problem if
> "ppc_swiotlb_enable" is
> > only demanded by PCI/PCIe. One of the purposes of sending out these
> patches
> > is to let us start a discussion for this problem in upstream.
>=20
> When sending out a patchset like that, label it as [RFC PATCH] (request
> for comments), and mention all known problems to be resolved.
>=20
> -Scott

I got it.
Thanks for your remind.
-Jia Hongtao.
