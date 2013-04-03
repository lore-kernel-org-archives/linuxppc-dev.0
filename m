Return-Path: <joro@8bytes.org>
Received: from mail.8bytes.org (8bytes.org [85.214.48.195])
 by ozlabs.org (Postfix) with ESMTP id CAFF22C0131
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 19:08:41 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.8bytes.org (Postfix) with SMTP id 0180512AFB8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 10:08:36 +0200 (CEST)
Date: Wed, 3 Apr 2013 10:08:35 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Sethi Varun-B16395 <B16395@freescale.com>
Subject: Re: [PATCH 4/5 v11] iommu/fsl: Add additional iommu attributes
 required by the PAMU driver.
Message-ID: <20130403080835.GW30540@8bytes.org>
References: <1364500442-20927-1-git-send-email-Varun.Sethi@freescale.com>
 <1364500442-20927-5-git-send-email-Varun.Sethi@freescale.com>
 <20130402151011.GH15687@8bytes.org>
 <C5ECD7A89D1DC44195F34B25E172658D45047E@039-SN2MPN1-013.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D45047E@039-SN2MPN1-013.039d.mgd.msft.net>
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

On Wed, Apr 03, 2013 at 05:21:16AM +0000, Sethi Varun-B16395 wrote:
> > I would prefer these PAMU specific enum and struct to be in a pamu-
> > specific iommu-header.
> > 
> 
> [Sethi Varun-B16395] But, these would be used by the IOMMU API users
> (e.g. VFIO), they shouldn't depend on PAMU specific headers.

Drivers that use PAMU specifics (like the PAMU specific VFIO parts) can
also include the PAMU specific header.


	Joerg
