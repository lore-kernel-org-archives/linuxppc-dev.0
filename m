Return-Path: <boris.brezillon@bootlin.com>
Received: from mail.bootlin.com (mail.bootlin.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 41W5Gr2pdKzF35L
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 04:27:25 +1000 (AEST)
Date: Wed, 18 Jul 2018 20:27:20 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Brian Norris
 <computersforpeace@gmail.com>, Boris Brezillon
 <boris.brezillon@free-electrons.com>, Marek Vasut <marek.vasut@gmail.com>,
 Richard Weinberger <richard@nod.at>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Timothy Pearson
 <tpearson@raptorengineering.com>, linux-mtd@lists.infradead.org, Michael
 Ellerman <mpe@ellerman.id.au>, Miquel Raynal <miquel.raynal@bootlin.com>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Paul Mackerras
 <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, Cyril Bur
 <cyrilbur@gmail.com>
Subject: Re: [PATCH] mtd: powernv_flash: set of_node in mtd's dev
Message-ID: <20180718202720.65e0ba15@bbrezillon>
In-Reply-To: <20180713081559.4373-1-zajec5@gmail.com>
References: <20180713081559.4373-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 13 Jul 2018 10:15:59 +0200
Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> wrote:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> This enables some features implemented in mtd subsystem like reading
> label and partitioning info from DT.
>=20
> Reported-by: Timothy Pearson <tpearson@raptorengineering.com>
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

Applied.

Thanks,

Boris

> ---
>  drivers/mtd/devices/powernv_flash.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/po=
wernv_flash.c
> index c1312b141ae0..33593122e49b 100644
> --- a/drivers/mtd/devices/powernv_flash.c
> +++ b/drivers/mtd/devices/powernv_flash.c
> @@ -223,6 +223,7 @@ static int powernv_flash_set_driver_info(struct devic=
e *dev,
>  	mtd->_read =3D powernv_flash_read;
>  	mtd->_write =3D powernv_flash_write;
>  	mtd->dev.parent =3D dev;
> +	mtd_set_of_node(mtd, dev->of_node);
>  	return 0;
>  }
> =20
