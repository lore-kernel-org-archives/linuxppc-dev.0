Return-Path: <B32616@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 75B532C0083
 for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2012 00:48:45 +1000 (EST)
From: Liu Qiang-B32616 <B32616@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, "dan.j.williams@intel.com"
 <dan.j.williams@intel.com>
Subject: RE: [PATCH] dma/fsldma: fix a compilation warnings
Date: Tue, 31 Jul 2012 14:48:38 +0000
Message-ID: <BCB48C05FCE8BC4D9E61E841ECBE6DB70C5FA7@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1343743058-8013-1-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1343743058-8013-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "vinod.koul@intel.com" <vinod.koul@intel.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kumar,=0A=
________________________________________=0A=
> From: Linuxppc-dev [linuxppc-dev-bounces+qiang.liu=3Dfreescale.com@lists.=
ozlabs.org] on behalf of Kumar Gala [galak@kernel.crashing.org]=0A=
> Sent: Tuesday, July 31, 2012 8:57 AM=0A=
> To: dan.j.williams@intel.com=0A=
> Cc: vinod.koul@intel.com; linuxppc-dev@ozlabs.org=0A=
> Subject: [PATCH] dma/fsldma: fix a compilation warnings=0A=
=0A=
> drivers/dma/fsldma.c: In function 'fsl_dma_tx_submit':=0A=
> drivers/dma/fsldma.c:409:15: warning: 'cookie' may be used uninitialized =
in this function=0A=
> =0A=
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>=0A=
> ---=0A=
>  drivers/dma/fsldma.c |    2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c=0A=
> index 8f84761..6194eb7 100644=0A=
> --- a/drivers/dma/fsldma.c=0A=
> +++ b/drivers/dma/fsldma.c=0A=
> @@ -406,7 +406,7 @@ static dma_cookie_t fsl_dma_tx_submit(struct dma_asyn=
c_tx_descriptor *tx)=0A=
>        struct fsl_desc_sw *desc =3D tx_to_fsl_desc(tx);=0A=
>        struct fsl_desc_sw *child;=0A=
>         unsigned long flags;=0A=
> -       dma_cookie_t cookie;=0A=
> +       dma_cookie_t cookie =3D 0;=0A=
I have already submitted a patch to fix it. Please refer to:=0A=
https://lists.ozlabs.org/pipermail/linuxppc-dev/2012-July/099819.html=0A=
=0A=
Thanks.=0A=
=0A=
>         spin_lock_irqsave(&chan->desc_lock, flags);=0A=
> =0A=
> --=0A=
> 1.7.9.7=0A=
=0A=
_______________________________________________=0A=
Linuxppc-dev mailing list=0A=
Linuxppc-dev@lists.ozlabs.org=0A=
https://lists.ozlabs.org/listinfo/linuxppc-dev=0A=
=0A=
