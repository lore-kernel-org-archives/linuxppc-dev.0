Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D298A2C007D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2012 10:14:11 +1000 (EST)
Date: Wed, 19 Sep 2012 19:14:02 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC][PATCH 0/3] iommu/fsl: Freescale PAMU driver and IOMMU API
 implementation.
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <A6B66C5D-71EA-4E9F-8347-7413479BD3FC@kernel.crashing.org>
 (from galak@kernel.crashing.org on Wed Sep 19 08:49:14 2012)
Message-ID: <1348100042.22800.22@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: joerg.roedel@amd.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org,
 "<b16395@freescale.com>" <b16395@freescale.com>,
 Varun Sethi <Varun.Sethi@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/19/2012 08:49:14 AM, Kumar Gala wrote:
>=20
> On Sep 19, 2012, at 8:17 AM, <b16395@freescale.com> =20
> <b16395@freescale.com> wrote:
>=20
> > From: Varun Sethi <Varun.Sethi@freescale.com>
> >
> > This patchset provides the Freescale PAMU (Peripheral Access =20
> Management Unit) driver
> > and the corresponding IOMMU API implementation. PAMU is the IOMMU =20
> present on Freescale
> > QorIQ platforms. PAMU can authorize memory access, remap the memory =20
> address, and remap
> > the I/O transaction type.
> >
> > This set consists of the following patches:
> > 1. Addition of new field in the device (powerpc) archdata structure =20
> for storing iommu domain information
> >   pointer. This pointer is stored when the device is attached to a =20
> particular iommu domain.
> > 2. Addition of domain attributes required by the PAMU driver IOMMU =20
> API.
> > 3. PAMU driver and IOMMU API implementation.
> >
> > Varun Sethi (3):
> >  Store iommu domain information pointer in archdata.
> >  Add iommu domain attributes required by fsl PAMU driver.
> >  FSL PAMU driver and IOMMU API implementation.
> >
> > arch/powerpc/include/asm/device.h |    4 +
> > drivers/iommu/Kconfig             |    7 +
> > drivers/iommu/Makefile            |    1 +
> > drivers/iommu/fsl_pamu.c          | 1033 =20
> +++++++++++++++++++++++++++++++++++++
> > drivers/iommu/fsl_pamu.h          |  377 ++++++++++++++
> > drivers/iommu/fsl_pamu_domain.c   |  990 =20
> +++++++++++++++++++++++++++++++++++
> > drivers/iommu/fsl_pamu_domain.h   |   94 ++++
> > drivers/iommu/fsl_pamu_proto.h    |   49 ++
> > include/linux/iommu.h             |   30 ++
> > 9 files changed, 2585 insertions(+), 0 deletions(-)
> > create mode 100644 drivers/iommu/fsl_pamu.c
> > create mode 100644 drivers/iommu/fsl_pamu.h
> > create mode 100644 drivers/iommu/fsl_pamu_domain.c
> > create mode 100644 drivers/iommu/fsl_pamu_domain.h
> > create mode 100644 drivers/iommu/fsl_pamu_proto.h
>=20
> I assume that another patch series will add device tree binding spec =20
> and update device trees for SoCs with PAMU?

The device trees already have PAMU in them.  A binding would be nice, =20
though.

-Scott=
