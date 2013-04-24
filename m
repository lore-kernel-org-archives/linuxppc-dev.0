Return-Path: <joro@8bytes.org>
Received: from mail.8bytes.org (8bytes.org [85.214.48.195])
 by ozlabs.org (Postfix) with ESMTP id CEFCC2C00F3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 20:51:24 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.8bytes.org (Postfix) with SMTP id 3B1F412B114
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 12:51:20 +0200 (CEST)
Date: Wed, 24 Apr 2013 12:51:18 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Sethi Varun-B16395 <B16395@freescale.com>
Subject: Re: [PATCH 2/3 v14] iommu/fsl: Add additional iommu attributes
 required by the PAMU driver.
Message-ID: <20130424105117.GI17148@8bytes.org>
References: <1366691726-9023-1-git-send-email-Varun.Sethi@freescale.com>
 <1366691726-9023-2-git-send-email-Varun.Sethi@freescale.com>
 <20130423133837.GG17148@8bytes.org>
 <C5ECD7A89D1DC44195F34B25E172658D4B4D9A@039-SN2MPN1-011.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D4B4D9A@039-SN2MPN1-011.039d.mgd.msft.net>
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

On Tue, Apr 23, 2013 at 02:10:25PM +0000, Sethi Varun-B16395 wrote:
> I think it's fine to have the header under linux, actually I also the
> intel-iommu header under linux.

Yes, the difference is that VT-d runs on x86 and on ia64. So there is no
single arch where the header could be placed. The amd-iommu.h file on
the other hand is x86 only and should also be moved to asm/, as I just
found out :)

And as long as PAMU is only needed on a single architecture the header
should also be arch-specific. If that changes someday the header can be
moved to a generic place.


	Joerg
