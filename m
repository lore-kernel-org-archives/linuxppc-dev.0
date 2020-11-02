Return-Path: <SRS0=b2NF=EI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C662C00A89
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2020 12:59:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B80B222BA
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2020 12:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B80B222BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CPtKL4GnjzDqQf
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2020 23:59:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=bootlin.com (client-ip=217.70.178.242;
 helo=mslow2.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=bootlin.com
Received: from mslow2.mail.gandi.net (mslow2.mail.gandi.net [217.70.178.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CPtCT5rZVzDqHh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Nov 2020 23:54:12 +1100 (AEDT)
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
 by mslow2.mail.gandi.net (Postfix) with ESMTP id 71C413A9340
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Nov 2020 12:53:20 +0000 (UTC)
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id AF340C0011;
 Mon,  2 Nov 2020 12:52:38 +0000 (UTC)
Date: Mon, 2 Nov 2020 13:52:37 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 23/23] mtd: devices: powernv_flash: Add function names
 to headers and fix 'dev'
Message-ID: <20201102135237.7a03b817@xps13>
In-Reply-To: <20201102115406.1074327-24-lee.jones@linaro.org>
References: <20201102115406.1074327-1-lee.jones@linaro.org>
 <20201102115406.1074327-24-lee.jones@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: vigneshr@ti.com, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Richard Weinberger <richard@nod.at>,
 linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Cyril Bur <cyril.bur@au1.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Lee,

Lee Jones <lee.jones@linaro.org> wrote on Mon,  2 Nov 2020 11:54:06
+0000:

> Fixes the following W=3D1 kernel build warning(s):
>=20
>  drivers/mtd/devices/powernv_flash.c:129: warning: Cannot understand  * @=
mtd: the device
>  drivers/mtd/devices/powernv_flash.c:145: warning: Cannot understand  * @=
mtd: the device
>  drivers/mtd/devices/powernv_flash.c:161: warning: Cannot understand  * @=
mtd: the device
>  drivers/mtd/devices/powernv_flash.c:184: warning: Function parameter or =
member 'dev' not described in 'powernv_flash_set_driver_info'
>=20
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Cyril Bur <cyril.bur@au1.ibm.com>
> Cc: linux-mtd@lists.infradead.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mtd/devices/powernv_flash.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/po=
wernv_flash.c
> index 0b757d9ba2f6b..32cb0e649096f 100644
> --- a/drivers/mtd/devices/powernv_flash.c
> +++ b/drivers/mtd/devices/powernv_flash.c
> @@ -126,6 +126,8 @@ static int powernv_flash_async_op(struct mtd_info *mt=
d, enum flash_op op,
>  }
> =20
>  /**
> + * powernv_flash_read
> + *

Perhaps we should not add blank lines if the rest of the file does not
already have such spacing (see below).

>   * @mtd: the device
>   * @from: the offset to read from
>   * @len: the number of bytes to read
> @@ -142,6 +144,7 @@ static int powernv_flash_read(struct mtd_info *mtd, l=
off_t from, size_t len,
>  }
> =20
>  /**
> + * powernv_flash_write
>   * @mtd: the device
>   * @to: the offset to write to
>   * @len: the number of bytes to write
> @@ -158,6 +161,7 @@ static int powernv_flash_write(struct mtd_info *mtd, =
loff_t to, size_t len,
>  }
> =20
>  /**
> + * powernv_flash_erase
>   * @mtd: the device
>   * @erase: the erase info
>   * Returns 0 if erase successful or -ERRNO if an error occurred
> @@ -176,7 +180,7 @@ static int powernv_flash_erase(struct mtd_info *mtd, =
struct erase_info *erase)
> =20
>  /**
>   * powernv_flash_set_driver_info - Fill the mtd_info structure and docg3
> - * structure @pdev: The platform device
> + * @dev: The device structure
>   * @mtd: The structure to fill
>   */
>  static int powernv_flash_set_driver_info(struct device *dev,


Thanks,
Miqu=C3=A8l
