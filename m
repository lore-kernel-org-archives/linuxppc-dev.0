Return-Path: <B32616@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F20A72C0089
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 12:30:57 +1000 (EST)
From: Liu Qiang-B32616 <B32616@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: RE: [linuxppc-release] [PATCH 4/4] Talitos: fix the issue of dma
 memory leak
Date: Wed, 11 Jul 2012 02:30:48 +0000
Message-ID: <BCB48C05FCE8BC4D9E61E841ECBE6DB70C0296@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1341900014-20915-1-git-send-email-qiang.liu@freescale.com>
 <4FFC9DE1.5060502@freescale.com>
In-Reply-To: <4FFC9DE1.5060502@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Herbert Xu <herbert@gondor.hengli.com.au>,
 "David S. Miller" <davem@davemloft.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Tabi Timur-B04825
> Sent: Wednesday, July 11, 2012 5:26 AM
> To: Liu Qiang-B32616
> Cc: linux-crypto@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; Herbert
> Xu; Li Yang-R58472; David S. Miller
> Subject: Re: [linuxppc-release] [PATCH 4/4] Talitos: fix the issue of dma
> memory leak
>=20
> Qiang Liu wrote:
> > An error will be happened when test with mass data:
>=20
> Please don't use the phrase "fix the issue" in patch summaries.  It's
> redundant.
>=20
> This patch should be titled,
>=20
> "drivers/crypto: fix memory leak in Talitos driver"
>=20
> > diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c index
> > 81f8497..a7da48c 100644
> > --- a/drivers/crypto/talitos.c
> > +++ b/drivers/crypto/talitos.c
> > @@ -264,7 +264,7 @@ static void flush_channel(struct device *dev, int
> ch, int error, int reset_ch)
> >  			else
> >  				status =3D error;
> >
> > -		dma_unmap_single(dev, request->dma_desc,
> > +		 dma_unmap_single(priv->dev, request->dma_desc,
>=20
> You have an indentation problem here.
My fault, I will correct it and resend again. Thanks.

>=20
> --
> Timur Tabi
> Linux kernel developer at Freescale
