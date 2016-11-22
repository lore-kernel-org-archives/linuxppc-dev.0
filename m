Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNHTr5ZfJzDvxT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 18:41:36 +1100 (AEDT)
Date: Tue, 22 Nov 2016 01:41:26 -0600
From: Scott Wood <oss@buserror.net>
To: jun <jun.yang@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org
Message-ID: <20161122074126.GA15587@home.buserror.net>
References: <1477500644-31812-1-git-send-email-jun.yang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477500644-31812-1-git-send-email-jun.yang@nxp.com>
Subject: Re: fsl_pamu: erratum a007907 should be applied on all versions of
 E6500 chips.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 27, 2016 at 12:50:44AM +0800, jun wrote:
> Signed-off-by: jun <jun.yang@nxp.com>
> ---
>  drivers/iommu/fsl_pamu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
> index db3a1cd..a8fe503 100644
> --- a/drivers/iommu/fsl_pamu.c
> +++ b/drivers/iommu/fsl_pamu.c
> @@ -668,7 +668,7 @@ static bool has_erratum_a007907(void)
>  {
>  	u32 pvr = mfspr(SPRN_PVR);
>  
> -	if (PVR_VER(pvr) == PVR_VER_E6500 && PVR_REV(pvr) <= 0x20)
> +	if (PVR_VER(pvr) == PVR_VER_E6500)
>  		return true;
>  
>  	return false;

This needs to be sent to the IOMMU maintainer and list.

-Scott
