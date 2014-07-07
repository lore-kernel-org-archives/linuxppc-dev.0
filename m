Return-Path: <Varun.Sethi@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0241.outbound.protection.outlook.com [207.46.163.241])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 638291A000A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jul 2014 18:55:22 +1000 (EST)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH 0/3] iommu/fsl: Fixes for the PAMU driver.
Date: Mon, 7 Jul 2014 08:55:15 +0000
Message-ID: <e311aca174f04752a2ea27954ee1be0d@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1403618237-26248-1-git-send-email-Varun.Sethi@freescale.com>
 <20140707083216.GA1958@8bytes.org>
In-Reply-To: <20140707083216.GA1958@8bytes.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
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

Thanks Joerg.

> -----Original Message-----
> From: Joerg Roedel [mailto:joro@8bytes.org]
> Sent: Monday, July 07, 2014 2:02 PM
> To: Sethi Varun-B16395
> Cc: iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> linuxppc-dev@lists.ozlabs.org; alex.williamson@redhat.com
> Subject: Re: [PATCH 0/3] iommu/fsl: Fixes for the PAMU driver.
>=20
> On Tue, Jun 24, 2014 at 07:27:14PM +0530, Varun Sethi wrote:
> > This patch set contains fixes for the PAMU driver.
> > The patches are based on 3.16-rc1.
> >
> > Varun Sethi (3):
> >   Fix PAMU window size check.
> >   Fix the device domain attach condition.
> >   Fix the error condition during iommu group creation.
> >
> >  drivers/iommu/fsl_pamu.c        |    8 ++++----
> >  drivers/iommu/fsl_pamu_domain.c |   19 +++++++++----------
> >  2 files changed, 13 insertions(+), 14 deletions(-)
>=20
> Applied to iommu/fixes, thanks.
>=20
