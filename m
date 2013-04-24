Return-Path: <B16395@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D440E2C00DE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 21:21:36 +1000 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH 2/3 v14] iommu/fsl: Add additional iommu attributes
 required by the PAMU driver.
Date: Wed, 24 Apr 2013 11:21:14 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D4B820D@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1366691726-9023-1-git-send-email-Varun.Sethi@freescale.com>
 <1366691726-9023-2-git-send-email-Varun.Sethi@freescale.com>
 <20130423133837.GG17148@8bytes.org>
 <C5ECD7A89D1DC44195F34B25E172658D4B4D9A@039-SN2MPN1-011.039d.mgd.msft.net>
 <20130424105117.GI17148@8bytes.org>
In-Reply-To: <20130424105117.GI17148@8bytes.org>
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
> Sent: Wednesday, April 24, 2013 4:21 PM
> To: Sethi Varun-B16395
> Cc: iommu@lists.linux-foundation.org; linuxppc-dev@lists.ozlabs.org;
> linux-kernel@vger.kernel.org; galak@kernel.crashing.org;
> benh@kernel.crashing.org; Yoder Stuart-B08248; Wood Scott-B07421
> Subject: Re: [PATCH 2/3 v14] iommu/fsl: Add additional iommu attributes
> required by the PAMU driver.
>=20
> On Tue, Apr 23, 2013 at 02:10:25PM +0000, Sethi Varun-B16395 wrote:
> > I think it's fine to have the header under linux, actually I also the
> > intel-iommu header under linux.
>=20
> Yes, the difference is that VT-d runs on x86 and on ia64. So there is no
> single arch where the header could be placed. The amd-iommu.h file on the
> other hand is x86 only and should also be moved to asm/, as I just found
> out :)
>=20
> And as long as PAMU is only needed on a single architecture the header
> should also be arch-specific. If that changes someday the header can be
> moved to a generic place.
>=20
Ok, I will post the next version of the patch set.

-Varun
