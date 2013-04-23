Return-Path: <B08248@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 633A12C00CA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 01:26:41 +1000 (EST)
From: Yoder Stuart-B08248 <B08248@freescale.com>
To: Joerg Roedel <joro@8bytes.org>, Sethi Varun-B16395 <B16395@freescale.com>
Subject: RE: [PATCH 2/3 v14] iommu/fsl: Add additional iommu attributes
 required by the PAMU driver.
Date: Tue, 23 Apr 2013 15:26:25 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E15035BE00E@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1366691726-9023-1-git-send-email-Varun.Sethi@freescale.com>
 <1366691726-9023-2-git-send-email-Varun.Sethi@freescale.com>
 <20130423133837.GG17148@8bytes.org>
In-Reply-To: <20130423133837.GG17148@8bytes.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
> Sent: Tuesday, April 23, 2013 8:39 AM
> To: Sethi Varun-B16395
> Cc: iommu@lists.linux-foundation.org; linuxppc-dev@lists.ozlabs.org; linu=
x-kernel@vger.kernel.org;
> galak@kernel.crashing.org; benh@kernel.crashing.org; Yoder Stuart-B08248;=
 Wood Scott-B07421
> Subject: Re: [PATCH 2/3 v14] iommu/fsl: Add additional iommu attributes r=
equired by the PAMU driver.
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
> >  include/linux/fsl_pamu_stash.h |   39 ++++++++++++++++++++++++++++++++=
+++++++
>=20
> Isn't asm/ for your architecture a better place for that header?

The PAMU isn't strictly tied to Power architecture, although
that is where it is implemented now.  It could be implemented
on ARM for example.

Stuart
