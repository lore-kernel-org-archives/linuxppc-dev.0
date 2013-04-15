Return-Path: <B16395@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BC2102C00E3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2013 03:13:12 +1000 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH 1/3] iommu: Move swap_pci_ref function to pci.h.
Date: Mon, 15 Apr 2013 17:13:01 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D486DF2@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1365966722-1804-1-git-send-email-Varun.Sethi@freescale.com>
 <20130415145834.GR6858@8bytes.org>
In-Reply-To: <20130415145834.GR6858@8bytes.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yoder Stuart-B08248 <B08248@freescale.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fine, I will move it to iommu.h.

-Varun

> -----Original Message-----
> From: Joerg Roedel [mailto:joro@8bytes.org]
> Sent: Monday, April 15, 2013 8:29 PM
> To: Sethi Varun-B16395
> Cc: Yoder Stuart-B08248; Wood Scott-B07421; iommu@lists.linux-
> foundation.org; linuxppc-dev@lists.ozlabs.org; linux-
> kernel@vger.kernel.org; galak@kernel.crashing.org;
> benh@kernel.crashing.org; bhelgaas@google.com
> Subject: Re: [PATCH 1/3] iommu: Move swap_pci_ref function to pci.h.
>=20
> On Mon, Apr 15, 2013 at 12:42:00AM +0530, Varun Sethi wrote:
> > swap_pci_ref function is used by the IOMMU API code for swapping pci
> > device pointers, while determining the iommu group for the device.
> > Currently this function was being implemented for different IOMMU
> drivers.
> > This patch moves the function to pci.h so that the implementation can
> > be shared across various IOMMU drivers.
>=20
> The function is only used in IOMMU code, so I think its fine to keep it
> there (unless Bjorn disagrees and wants it in PCI code).
>=20
>=20
> 	Joerg
>=20
>=20
