Return-Path: <joro@8bytes.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 63DAB1A01C0
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Sep 2014 00:04:22 +1000 (EST)
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E13A51400B9
 for <linuxppc-dev@ozlabs.org>; Sat,  6 Sep 2014 00:04:21 +1000 (EST)
Date: Fri, 5 Sep 2014 16:04:15 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Varun Sethi <Varun.Sethi@freescale.com>
Subject: Re: [PATCH v2] iommu/fsl: Fix warning resulting from adding PCI
 device twice
Message-ID: <20140905140414.GA11931@8bytes.org>
References: <1409830725-4469-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1409830725-4469-1-git-send-email-Varun.Sethi@freescale.com>
Cc: linuxppc-dev@ozlabs.org, iommu@lists.linux-foundation.org,
 alex.williamson@redhat.com, Emilian.Medve@freescale.com,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 04, 2014 at 05:08:45PM +0530, Varun Sethi wrote:
> iommu_group_get_for_dev determines the iommu group for the PCI device and adds
> the device to the group.
> 
> In the PAMU driver we were again adding the device to the same group without checking
> if the device already had an iommu group. This resulted in the following warning.
>
> [...]
> 
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> ---
> v2 changes
> - directly check for the device iommu_group
> 
>  drivers/iommu/fsl_pamu_domain.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Applied to iommu/fixes and added stable tag, thanks.
