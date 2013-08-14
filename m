Return-Path: <B16395@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 340302C01F1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 02:44:29 +1000 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH 1/3] powerpc: Add iommu domain pointer to device archdata
Date: Wed, 14 Aug 2013 16:44:18 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D0A42F5C6@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1373863857-27239-1-git-send-email-Varun.Sethi@freescale.com>
 <20130814094802.GC4491@8bytes.org>
 <C5ECD7A89D1DC44195F34B25E172658D0A42CDB5@039-SN2MPN1-013.039d.mgd.msft.net>
 <20130814161522.GP28811@8bytes.org>
In-Reply-To: <20130814161522.GP28811@8bytes.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yoder Stuart-B08248 <B08248@freescale.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
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
> Sent: Wednesday, August 14, 2013 9:45 PM
> To: Sethi Varun-B16395
> Cc: iommu@lists.linux-foundation.org; linuxppc-dev@lists.ozlabs.org;
> linux-kernel@vger.kernel.org; benh@kernel.crashing.org;
> galak@kernel.crashing.org; alex.williamson@redhat.com; Yoder Stuart-
> B08248; Wood Scott-B07421
> Subject: Re: [PATCH 1/3] powerpc: Add iommu domain pointer to device
> archdata
>=20
> On Wed, Aug 14, 2013 at 09:56:11AM +0000, Sethi Varun-B16395 wrote:
> > Please find the .config file attached with this mail.
>=20
> Fantastic, thanks. The build works fine, I'll include the driver into my
> next-branch. I also have two minor clean-up patches on-top, just if you
> where wondering.
>=20
>=20
> 	Joerg
>=20
>=20
