Return-Path: <B38951@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe001.messaging.microsoft.com [213.199.154.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0FB8DB6FC2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jun 2012 12:33:33 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Bhushan Bharat-R65777 <R65777@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "galak@kernel.crashing.org" <galak@kernel.crashing.org>
Subject: RE: [PATCH 0/6] Description for PCI patches using platform driver
Date: Mon, 11 Jun 2012 02:33:04 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01A0921B@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1339148527-16911-1-git-send-email-B38951@freescale.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D03D71F38@039-SN2MPN1-022.039d.mgd.msft.net>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D03D71F38@039-SN2MPN1-022.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Li Yang-R58472 <r58472@freescale.com>,
 Wood Scott-B07421 <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Bhushan Bharat-R65777
> Sent: Friday, June 08, 2012 6:47 PM
> To: Jia Hongtao-B38951; linuxppc-dev@lists.ozlabs.org;
> galak@kernel.crashing.org
> Cc: Li Yang-R58472; benh@kernel.crashing.org; Wood Scott-B07421
> Subject: RE: [PATCH 0/6] Description for PCI patches using platform
> driver
>=20
>=20
> > -----Original Message-----
> > From: Jia Hongtao-B38951
> > Sent: Friday, June 08, 2012 3:12 PM
> > To: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org
> > Cc: Li Yang-R58472; benh@kernel.crashing.org; Wood Scott-B07421;
> Bhushan Bharat-
> > R65777; Jia Hongtao-B38951
> > Subject: [PATCH 0/6] Description for PCI patches using platform driver
> >
> > This series of patches are to unify pci initialization code and add PM
> support
> > for all 85xx/86xx powerpc boards. But two side effects are introduced
> by this
> > mechanism which listed below:
> >
> > 1. of_platform_bus_probe() will be called twice but in some cases
> duplication
> >    warning occured. We fix this in [PATCH 5/6].
> >
> > 2. Edac driver failed to register pci nodes as platform devices. We fix
> this
> >    in [PATCH 6/6].
>=20
> With these patches will not the SWIOTLB will not be initialized even if
> PCI/PCIe demanded?
>=20
> Thanks
> -Bharat
>=20

These patches still have the swiotlb init problem if "ppc_swiotlb_enable" i=
s
only demanded by PCI/PCIe. One of the purposes of sending out these patches
is to let us start a discussion for this problem in upstream.

-Jia Hongtao.
