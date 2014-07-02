Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0139.outbound.protection.outlook.com [207.46.163.139])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 89C791A0015
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Jul 2014 17:54:44 +1000 (EST)
Message-ID: <53B3B8B9.30400@Freescale.com>
Date: Wed, 2 Jul 2014 02:46:01 -0500
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Varun Sethi <Varun.Sethi@Freescale.com>,
 <iommu@lists.linux-foundation.org>, <joro@8bytes.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <alex.williamson@redhat.com>
Subject: Re: [PATCH 1/3] iommu/fsl: Fix PAMU window size check.
References: <1403618237-26248-1-git-send-email-Varun.Sethi@freescale.com>
 <1403618237-26248-2-git-send-email-Varun.Sethi__13822.953499812$1403630309$gmane$org@freescale.com>
In-Reply-To: <1403618237-26248-2-git-send-email-Varun.Sethi__13822.953499812$1403630309$gmane$org@freescale.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/24/2014 08:57 AM, Varun Sethi wrote:
> is_power_of_2 requires an unsigned long parameter which would
> lead to truncation of 64 bit values on 32 bit architectures.
> 
> __ffs also expects an unsigned long parameter thus won't work
> for 64 bit values on 32 bit architectures.
> 
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> ---
>  drivers/iommu/fsl_pamu.c        |    8 ++++----
>  drivers/iommu/fsl_pamu_domain.c |    2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)

Tested-by: Emil Medve <Emilian.Medve@Freescale.com>

On a P4080 DS (i.e. 32-bit SoC)


Cheers,
