Return-Path: <jun.yang@nxp.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0056.outbound.protection.outlook.com [104.47.1.56])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNJrw2jS2zDvw2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 19:43:11 +1100 (AEDT)
From: Jun Yang <jun.yang@nxp.com>
To: Scott Wood <oss@buserror.net>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: fsl_pamu: erratum a007907 should be applied on all versions of
 E6500 chips.
Date: Tue, 22 Nov 2016 08:43:05 +0000
Message-ID: <VI1PR0401MB20628C7AC37B0187C721F10F9DB40@VI1PR0401MB2062.eurprd04.prod.outlook.com>
References: <1477500644-31812-1-git-send-email-jun.yang@nxp.com>
 <20161122074126.GA15587@home.buserror.net>
In-Reply-To: <20161122074126.GA15587@home.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Scott,
Do you know the IOMMU maintainer's mail address?

BR
Jun

-----Original Message-----
From: Scott Wood [mailto:oss@buserror.net]=20
Sent: Tuesday, November 22, 2016 3:41 PM
To: Jun Yang
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: fsl_pamu: erratum a007907 should be applied on all versions of=
 E6500 chips.

On Thu, Oct 27, 2016 at 12:50:44AM +0800, jun wrote:
> Signed-off-by: jun <jun.yang@nxp.com>
> ---
>  drivers/iommu/fsl_pamu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c index=20
> db3a1cd..a8fe503 100644
> --- a/drivers/iommu/fsl_pamu.c
> +++ b/drivers/iommu/fsl_pamu.c
> @@ -668,7 +668,7 @@ static bool has_erratum_a007907(void)  {
>  	u32 pvr =3D mfspr(SPRN_PVR);
> =20
> -	if (PVR_VER(pvr) =3D=3D PVR_VER_E6500 && PVR_REV(pvr) <=3D 0x20)
> +	if (PVR_VER(pvr) =3D=3D PVR_VER_E6500)
>  		return true;
> =20
>  	return false;

This needs to be sent to the IOMMU maintainer and list.

-Scott
