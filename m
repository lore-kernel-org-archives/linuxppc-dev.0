Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D13CC282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 10:18:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BB7A218FE
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 10:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB7A218FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wDm83yCfzDqPn
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 21:18:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=collabora.com
 (client-ip=2a00:1098:0:82:1000:25:2eeb:e3e3; helo=bhuna.collabora.co.uk;
 envelope-from=boris.brezillon@collabora.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=collabora.com
X-Greylist: delayed 350 seconds by postgrey-1.36 at bilbo;
 Thu, 07 Feb 2019 19:43:32 AEDT
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wBfr1SsdzDqQv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 19:43:32 +1100 (AEDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 995792798E5;
 Thu,  7 Feb 2019 08:37:37 +0000 (GMT)
Date: Thu, 7 Feb 2019 09:37:34 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] mtd: powernv: SPDX and comment fixups
Message-ID: <20190207093734.400875cd@collabora.com>
In-Reply-To: <20190206003659.27107-1-joel@jms.id.au>
References: <20190206003659.27107-1-joel@jms.id.au>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 07 Feb 2019 21:16:42 +1100
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
Cc: linuxppc-dev@lists.ozlabs.org, Marek Vasut <marek.vasut@gmail.com>,
 linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello Joel,

On Wed,  6 Feb 2019 11:06:58 +1030
Joel Stanley <joel@jms.id.au> wrote:

> This converts the powernv flash driver to use SPDX, and adds some
> clarifying comments that came out of a discussion on how the mtd driver
> works.

Can you split that in 2 patches, one adding the SPDX header, and the
other one clarifying the driver behavior.

Thanks,

Boris

> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  drivers/mtd/devices/powernv_flash.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
> index 22f753e555ac..0bf43336c3f7 100644
> --- a/drivers/mtd/devices/powernv_flash.c
> +++ b/drivers/mtd/devices/powernv_flash.c
> @@ -1,17 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
>  /*
>   * OPAL PNOR flash MTD abstraction
>   *
>   * Copyright IBM 2015
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  #include <linux/kernel.h>
> @@ -261,6 +253,14 @@ static int powernv_flash_probe(struct platform_device *pdev)
>  	 * The current flash that skiboot exposes is one contiguous flash chip
>  	 * with an ffs partition at the start, it should prove easier for users
>  	 * to deal with partitions or not as they see fit
> +	 *
> +	 * When developing the skiboot MTD driver an experiment with FFS
> +	 * parsing in the kernel, and exposing a seperate /dev/mtdX for each
> +	 * partition (eg BOOTKERNEL, PAYLOAD, NVRAM, etc), was done.
> +	 *
> +	 * We didn't go with that as it meant users couldn't do a full flash
> +	 * re-write, as this can cause a partition to change size, and there
> +	 * wasn't a way to tell the MTD layer that a device has shrunk/grown.
>  	 */
>  	return mtd_device_register(&data->mtd, NULL, 0);
>  }

