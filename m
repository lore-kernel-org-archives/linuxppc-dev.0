Return-Path: <B16395@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 405B02C0080
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2012 03:57:41 +1100 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH 3/4 v5] iommu/fsl: Add iommu domain attributes required
 by fsl PAMU driver.
Date: Mon, 3 Dec 2012 16:57:29 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D2B2A51@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1353419697-31269-1-git-send-email-Varun.Sethi@freescale.com>
 <1353419697-31269-4-git-send-email-Varun.Sethi@freescale.com>
 <20121202140323.GO30633@8bytes.org>
In-Reply-To: <20121202140323.GO30633@8bytes.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Tabi Timur-B04825 <B04825@freescale.com>,
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
> From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
> bounces@lists.linux-foundation.org] On Behalf Of Joerg Roedel
> Sent: Sunday, December 02, 2012 7:33 PM
> To: Sethi Varun-B16395
> Cc: linux-kernel@vger.kernel.org; iommu@lists.linux-foundation.org; Wood
> Scott-B07421; linuxppc-dev@lists.ozlabs.org; Tabi Timur-B04825
> Subject: Re: [PATCH 3/4 v5] iommu/fsl: Add iommu domain attributes
> required by fsl PAMU driver.
>=20
> Hmm, we need to work out a good abstraction for this.
>=20
> On Tue, Nov 20, 2012 at 07:24:56PM +0530, Varun Sethi wrote:
> > Added the following domain attributes required by FSL PAMU driver:
> > 1. Subwindows field added to the iommu domain geometry attribute.
>=20
> Are the Subwindows mapped with full size or do you map only parts of the
> subwindows?
>=20
[Sethi Varun-B16395] It's possible to map a part of the subwindow i.e. size=
 of the mapping can be less than the sub window size.

> > +	 * This attribute indicates number of DMA subwindows supported by
> > +	 * the geometry. If there is a single window that maps the entire
> > +	 * geometry, attribute must be set to "1". A value of "0" implies
> > +	 * that this mechanism is not used at all(normal paging is used).
> > +	 * Value other than* "0" or "1" indicates the actual number of
> > +	 * subwindows.
> > +	 */
>=20
> This semantic is ugly, how about a feature detection mechanism?
>=20
[Sethi Varun-B16395] A feature mechanism to query the type of IOMMU?

-Varun
