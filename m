Return-Path: <B16395@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 110E52C0080
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2013 21:56:43 +1100 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH 2/6] powerpc/fsl_pci: Store the platform device
 information corresponding to the pci controller.
Date: Wed, 27 Feb 2013 10:56:31 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D3C24A9@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1361191939-21260-1-git-send-email-Varun.Sethi@freescale.com>
 <1361191939-21260-3-git-send-email-Varun.Sethi@freescale.com>
 <CALRxmdDc9TuxH7HgAF3_iLgatoaOUML6fUt8SU+sxHyz6ZVjfw@mail.gmail.com>
 <C5ECD7A89D1DC44195F34B25E172658D3BD338@039-SN2MPN1-013.039d.mgd.msft.net>
 <20130227104505.GE26252@8bytes.org>
In-Reply-To: <20130227104505.GE26252@8bytes.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>, Stuart Yoder <b08248@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yoder Stuart-B08248 <B08248@freescale.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch is present in the "next branch" of linux ppc tree maintained by =
Kumar Gala.
Following is the commit id:
52c5affc545053d37c0b05224bbf70f5336caa20

I am not sure if this would be part of 3.9-rc1.

Regards
varun

> -----Original Message-----
> From: Joerg Roedel [mailto:joro@8bytes.org]
> Sent: Wednesday, February 27, 2013 4:15 PM
> To: Sethi Varun-B16395
> Cc: Stuart Yoder; iommu@lists.linux-foundation.org; linuxppc-
> dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Wood Scott-B07421;
> Yoder Stuart-B08248
> Subject: Re: [PATCH 2/6] powerpc/fsl_pci: Store the platform device
> information corresponding to the pci controller.
>=20
> On Tue, Feb 26, 2013 at 06:16:10AM +0000, Sethi Varun-B16395 wrote:
> > This patch is not present in Joerg's tree and the add_device API in
> > the PAMU driver requires this patch.
>=20
> Will this patch be part of v3.9-rc1?
>=20
>=20
> 	Joerg
>=20
>=20
