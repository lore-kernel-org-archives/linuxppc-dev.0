Return-Path: <B16395@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 451CF2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jun 2013 00:30:30 +1000 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH 2/5 v11] powerpc: Add iommu domain pointer to device
 archdata
Date: Thu, 20 Jun 2013 14:29:30 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D5CB5D4@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1364500442-20927-1-git-send-email-Varun.Sethi@freescale.com>
 <1364500442-20927-3-git-send-email-Varun.Sethi@freescale.com>
 <AC9BAE34-A9CB-4A24-A357-0AA7734CE443@kernel.crashing.org>
In-Reply-To: <AC9BAE34-A9CB-4A24-A357-0AA7734CE443@kernel.crashing.org>
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

Hi Joerg,
My PAMU driver patches depend on this patch which was Ack by Kumar. Should =
I resubmit this patch as well?

Regards
Varun

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Thursday, April 11, 2013 11:46 PM
> To: Sethi Varun-B16395
> Cc: joro@8bytes.org; Yoder Stuart-B08248; Wood Scott-B07421;
> iommu@lists.linux-foundation.org; linuxppc-dev@lists.ozlabs.org; linux-
> kernel@vger.kernel.org; benh@kernel.crashing.org
> Subject: Re: [PATCH 2/5 v11] powerpc: Add iommu domain pointer to device
> archdata
>=20
>=20
> On Mar 28, 2013, at 2:53 PM, Varun Sethi wrote:
>=20
> > Add an iommu domain pointer to device (powerpc) archdata.  Devices are
> > attached to iommu domains and this pointer provides a mechanism to
> > correlate between a device and the associated iommu domain.  This
> > field is set when a device is attached to a domain.
> >
> > Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> > ---
> > - no change in v11.
> > - no change in v10.
> > - Added CONFIG_IOMMU_API in v9.
> > arch/powerpc/include/asm/device.h |    6 ++++++
> > 1 files changed, 6 insertions(+), 0 deletions(-)
>=20
> Acked-by: Kumar Gala <galak@kernel.crashing.org>
>=20
> - k
