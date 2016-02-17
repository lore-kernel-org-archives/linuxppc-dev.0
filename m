Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 573381A03DA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 08:49:20 +1100 (AEDT)
Message-ID: <1455745755.2463.86.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Raghav Dogra <raghav.dogra@nxp.com>, linux-mtd@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Cc: computersforpeace@gmail.com, prabhakar.kushwaha@nxp.com,
 leoli@freescale.com, Jaiprakash Singh <b44839@freescale.com>, Raghav Dogra
 <raghav@freescale.com>
Date: Wed, 17 Feb 2016 15:49:15 -0600
In-Reply-To: <1455708258-3831-1-git-send-email-raghav.dogra@nxp.com>
References: <1455708258-3831-1-git-send-email-raghav.dogra@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH][v3] mtd/ifc: Add support for IFC controller version 2.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-02-17 at 16:54 +0530, Raghav Dogra wrote:
> The new IFC controller version 2.0 has a different memory map page.
> Upto IFC 1.4 PAGE size is 4 KB and from IFC2.0 PAGE size is 64KB.
> This patch segregates the IFC global and runtime registers to appropriate
> PAGE sizes.
> 
> Signed-off-by: Jaiprakash Singh <b44839@freescale.com>
> Signed-off-by: Raghav Dogra <raghav@freescale.com>
> Acked-by: Li Yang <leoyang.li@nxp.com>
> Signed-off-by: Raghav Dogra <raghav.dogra@nxp.com>
> ---
> Changes for v3: not dependent on 
> "drivers/memory: Add deep sleep support for IFC" patch
> 
> Changes for v2: rebased to resolve conflicts
> Applicable to git://git.infradead.org/l2-mtd.git
> 
> This patch is dependent on "drivers/memory: Add deep sleep support for IFC"
> https://patchwork.ozlabs.org/patch/582762/
> which is also applicable to git://git.infradead.org/l2-mtd.git
> 
> This patch is the new version of following patch with changed title:
> https://patchwork.ozlabs.org/patch/557391/
> 
>  drivers/memory/fsl_ifc.c        | 36 ++++++++++-----------
>  drivers/mtd/nand/fsl_ifc_nand.c | 72 ++++++++++++++++++++++----------------
> ---
>  include/linux/fsl_ifc.h         | 45 +++++++++++++++++---------
>  3 files changed, 87 insertions(+), 66 deletions(-)

Acked-by: Scott Wood <oss@buserror.net>

-Scott
