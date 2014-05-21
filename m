Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0208.outbound.protection.outlook.com [207.46.163.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B17BD1A0814
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 06:50:27 +1000 (EST)
Message-ID: <1400705405.18239.92.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/2] mtd/spi: support en25s64 device
From: Scott Wood <scottwood@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Date: Wed, 21 May 2014 15:50:05 -0500
In-Reply-To: <1400666751-11459-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1400666751-11459-1-git-send-email-Shengzhou.Liu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-05-21 at 18:05 +0800, Shengzhou Liu wrote:
> Add support for EON en25s64 spi device.
> 
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> ---
>  drivers/mtd/devices/m25p80.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index 7eda71d..6989311 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -745,6 +745,7 @@ static const struct spi_device_id m25p_ids[] = {
>  	{ "en25q32b",   INFO(0x1c3016, 0, 64 * 1024,   64, 0) },
>  	{ "en25p64",    INFO(0x1c2017, 0, 64 * 1024,  128, 0) },
>  	{ "en25q64",    INFO(0x1c3017, 0, 64 * 1024,  128, SECT_4K) },
> +	{ "en25s64",    INFO(0x1c3817, 0, 64 * 1024,  128, 0) },
>  	{ "en25qh256",  INFO(0x1c7019, 0, 64 * 1024,  512, 0) },
>  
>  	/* ESMT */

This needs to be sent to the mtd and/or spi maintainers, not here.

What does this have to do with patch 2/2?  Don't put unrelated things in
the same patchset, especially when they're destined for different
maintainers.

-Scott
