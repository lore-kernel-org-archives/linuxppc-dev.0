Return-Path: <B16395@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 574DD2C0355
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2012 02:31:19 +1000 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [RFC][PATCH 1/3] iommu/fsl: Store iommu domain information
 pointer in archdata.
Date: Thu, 4 Oct 2012 16:30:58 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D1EFD59@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1348060632-12997-1-git-send-email-b16395@freescale.com>
 <1348060632-12997-2-git-send-email-b16395@freescale.com>
 <5BDB4D18-CB0D-4EBA-B38F-A278B7C00A61@kernel.crashing.org>
In-Reply-To: <5BDB4D18-CB0D-4EBA-B38F-A278B7C00A61@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "joerg.roedel@amd.com" <joerg.roedel@amd.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Wednesday, September 19, 2012 7:20 PM
> To: Sethi Varun-B16395
> Cc: iommu@lists.linux-foundation.org; joerg.roedel@amd.com; linux-
> kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; Sethi Varun-B16395
> Subject: Re: [RFC][PATCH 1/3] iommu/fsl: Store iommu domain information
> pointer in archdata.
>=20
>=20
> On Sep 19, 2012, at 8:17 AM, <b16395@freescale.com>
> <b16395@freescale.com> wrote:
>=20
> > From: Varun Sethi <Varun.Sethi@freescale.com>
> >
> > Add a new field in the device (powerpc) archdata structure for storing
> > iommu domain information pointer. This pointer is stored when the
> > device is attached to a particular domain.
> >
> > Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> > ---
> > arch/powerpc/include/asm/device.h |    4 ++++
> > 1 files changed, 4 insertions(+), 0 deletions(-)
>=20
> Not too familiar, but what does the IBM Server IOMMU do for iommu_domain?
>
[Sethi Varun-B16395] I am not sure if the IBM iommu driver implements the i=
ommu
API.

-Varun
=20
