Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A8B76B6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Sep 2010 22:55:34 +1000 (EST)
Subject: Re: [PATCH] fsldma: add support to 36-bit physical address
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1285066638-7473-1-git-send-email-leoli@freescale.com>
Date: Tue, 21 Sep 2010 07:55:22 -0500
Message-Id: <877FD0B5-19A7-4A16-831E-369B80B104EA@kernel.crashing.org>
References: <1285066638-7473-1-git-send-email-leoli@freescale.com>
To: Li Yang <leoli@freescale.com>
Cc: dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 21, 2010, at 5:57 AM, Li Yang wrote:

> Signed-off-by: Li Yang <leoli@freescale.com>
> ---

We really should have a sentence about how or why this works to address =
36-bit addressing.

> drivers/dma/fsldma.c |    3 ++-
> 1 files changed, 2 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index cea08be..9163552 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1,7 +1,7 @@
> /*
>  * Freescale MPC85xx, MPC83xx DMA Engine support
>  *
> - * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights =
reserved.
> + * Copyright (C) 2007-2009 Freescale Semiconductor, Inc. All rights =
reserved.
>  *
>  * Author:
>  *   Zhang Wei <wei.zhang@freescale.com>, Jul 2007
> @@ -1338,6 +1338,7 @@ static int __devinit fsldma_of_probe(struct =
platform_device *op,
> 	fdev->common.device_control =3D fsl_dma_device_control;
> 	fdev->common.dev =3D &op->dev;
>=20
> +	dma_set_mask(&op->dev, DMA_BIT_MASK(36));
> 	dev_set_drvdata(&op->dev, fdev);
>=20
> 	/*
> --=20
> 1.6.6-rc1.GIT
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
