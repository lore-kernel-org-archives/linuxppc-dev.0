Return-Path: <joro@8bytes.org>
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42KLdr4qgjzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 22:55:28 +1000 (AEST)
Date: Tue, 25 Sep 2018 14:55:23 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] iommu: Tidy up window attributes
Message-ID: <20180925125522.mzwsiao3ekqvcsuq@8bytes.org>
References: <96e8371cc3143a58c7a142d9ff1134ba7331dd0a.1537351779.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <96e8371cc3143a58c7a142d9ff1134ba7331dd0a.1537351779.git.robin.murphy@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 19, 2018 at 11:12:57AM +0100, Robin Murphy wrote:
> The external interface to get/set window attributes is already
> abstracted behind iommu_domain_{get,set}_attr(), so there's no real
> reason for the internal interface to be different. Since we only have
> one window-based driver anyway, clean up the core code by just moving
> the DOMAIN_ATTR_WINDOWS handling directly into the PAMU driver.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> Just a cleanup opportunity I spotted whilst poking around in the area.
> 
>  drivers/iommu/fsl_pamu_domain.c | 20 ++++++++++++++++++++
>  drivers/iommu/iommu.c           | 20 --------------------
>  2 files changed, 20 insertions(+), 20 deletions(-)

Nice cleanup, applied both patches, thanks Robin.
