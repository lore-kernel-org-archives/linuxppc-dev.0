Return-Path: <B16395@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 67BD72C015B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 00:10:32 +1000 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH 2/3 v14] iommu/fsl: Add additional iommu attributes
 required by the PAMU driver.
Date: Tue, 23 Apr 2013 14:10:25 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D4B4D9A@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1366691726-9023-1-git-send-email-Varun.Sethi@freescale.com>
 <1366691726-9023-2-git-send-email-Varun.Sethi@freescale.com>
 <20130423133837.GG17148@8bytes.org>
In-Reply-To: <20130423133837.GG17148@8bytes.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
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



> -----Original Message-----
> From: Joerg Roedel [mailto:joro@8bytes.org]
> Sent: Tuesday, April 23, 2013 7:09 PM
> To: Sethi Varun-B16395
> Cc: iommu@lists.linux-foundation.org; linuxppc-dev@lists.ozlabs.org;
> linux-kernel@vger.kernel.org; galak@kernel.crashing.org;
> benh@kernel.crashing.org; Yoder Stuart-B08248; Wood Scott-B07421
> Subject: Re: [PATCH 2/3 v14] iommu/fsl: Add additional iommu attributes
> required by the PAMU driver.
>=20
> On Tue, Apr 23, 2013 at 10:05:25AM +0530, Varun Sethi wrote:
> > Added the following domain attributes for the FSL PAMU driver:
> > 1. Added new iommu stash attribute, which allows setting of the
> >    LIODN specific stash id parameter through IOMMU API.
> > 2. Added an attribute for enabling/disabling DMA to a particular
> >    memory window.
> > 3. Added domain attribute to check for PAMUV1 specific constraints.
> >
> > Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> > ---
> > v14 changes:
> > - Add FSL prefix to PAMU attributes.
> > v13 changes:
> > - created a new file include/linux/fsl_pamu_stash.h for stash
> > attributes.
> > v12 changes:
> > - Moved PAMU specifc stash ids and structures to PAMU header file.
> > - no change in v11.
> > - no change in v10.
> >  include/linux/fsl_pamu_stash.h |   39
> +++++++++++++++++++++++++++++++++++++++
>=20
> Isn't asm/ for your architecture a better place for that header?
>=20
I think it's fine to have the header under linux, actually I also the intel=
-iommu header under linux.

-Varun
