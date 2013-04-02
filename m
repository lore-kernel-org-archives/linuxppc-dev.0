Return-Path: <B16395@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ABE712C01FE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 04:51:12 +1100 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH 0/5 v11] iommu/fsl: Freescale PAMU driver and IOMMU API
 implementation.
Date: Tue, 2 Apr 2013 17:50:50 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D44E415@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1364500442-20927-1-git-send-email-Varun.Sethi@freescale.com>
 <20130402162310.GJ15687@8bytes.org>
In-Reply-To: <20130402162310.GJ15687@8bytes.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yoder Stuart-B08248 <B08248@freescale.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Joerg Roedel [mailto:joro@8bytes.org]
> Sent: Tuesday, April 02, 2013 9:53 PM
> To: Sethi Varun-B16395
> Cc: Yoder Stuart-B08248; Wood Scott-B07421; iommu@lists.linux-
> foundation.org; linuxppc-dev@lists.ozlabs.org; linux-
> kernel@vger.kernel.org; galak@kernel.crashing.org;
> benh@kernel.crashing.org
> Subject: Re: [PATCH 0/5 v11] iommu/fsl: Freescale PAMU driver and IOMMU
> API implementation.
>=20
> On Fri, Mar 29, 2013 at 01:23:57AM +0530, Varun Sethi wrote:
> > This patchset provides the Freescale PAMU (Peripheral Access
> > Management Unit) driver and the corresponding IOMMU API
> > implementation. PAMU is the IOMMU present on Freescale QorIQ
> > platforms. PAMU can authorize memory access, remap the memory address,
> and remap the I/O transaction type.
> >
> > This set consists of the following patches:
> > 1.  Make iova dma_addr_t in the iommu_iova_to_phys API.
> > 2. Addition of new field in the device (powerpc) archdata structure for
> storing iommu domain information
> >    pointer.
> > 3. Add window permission flags in the iommu_domain_window_enable API.
> > 4. Add domain attributes for FSL PAMU driver.
> > 5. PAMU driver and IOMMU API implementation.
>=20
> Okay, I am about to apply patches 1 and 3 to a new ppc/pamu branch in my
> tree.
>=20
> As a general question, how did you test the IOMMU driver and what will
> you do in the future to avoid regressions?
>=20
I use a kernel module for testing the iommu_api support. The module allows =
for dynamic creation and deletion of iommu domains for the devices in the d=
evice tree. Also, the vfio support (under development) for Freescale SOCs w=
ith APMU hardware would depend on the PAMU driver.

-Varun
