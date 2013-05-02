Return-Path: <B16395@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E9CB12C00C7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 May 2013 23:26:35 +1000 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH 1/2 v15] iommu/fsl: Add additional iommu attributes
 required by the PAMU driver.
Date: Thu, 2 May 2013 13:26:05 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D4D308F@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1366803351-17429-1-git-send-email-Varun.Sethi@freescale.com>
 <C5ECD7A89D1DC44195F34B25E172658D4CBC45@039-SN2MPN1-011.039d.mgd.msft.net>
 <20130502101629.GA24440@8bytes.org>
In-Reply-To: <20130502101629.GA24440@8bytes.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Alex Williamson <alex.williamson@redhat.com>,
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
> From: joro@8bytes.org [mailto:joro@8bytes.org]
> Sent: Thursday, May 02, 2013 3:46 PM
> To: Sethi Varun-B16395
> Cc: iommu@lists.linux-foundation.org; linuxppc-dev@lists.ozlabs.org;
> linux-kernel@vger.kernel.org; galak@kernel.crashing.org;
> benh@kernel.crashing.org; Yoder Stuart-B08248; Wood Scott-B07421
> Subject: Re: [PATCH 1/2 v15] iommu/fsl: Add additional iommu attributes
> required by the PAMU driver.
>=20
> On Tue, Apr 30, 2013 at 05:09:32PM +0000, Sethi Varun-B16395 wrote:
> > Would you take this patchset for 3.10 merge?
>=20
> Not this time. The final patch came in very late and is pretty big too.
> For code of that size I would like to have a few weeks more testing in
> next and probably also a non-Freescale Reviewed-by.
[Sethi Varun-B16395] I would request you and Alex Williamson to review the =
patch and provide a Reviewed-by.

-Varun
