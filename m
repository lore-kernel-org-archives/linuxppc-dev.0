Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0236.outbound.protection.outlook.com [207.46.163.236])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 35CD21A0980
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 04:55:56 +1000 (EST)
Message-ID: <1403636101.26908.26.camel@snotra.buserror.net>
Subject: Re: [PATCH] spi: include "int ret" with macro
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang <B45475@freescale.com>
Date: Tue, 24 Jun 2014 13:55:01 -0500
In-Reply-To: <1403596509-12411-1-git-send-email-B45475@freescale.com>
References: <1403596509-12411-1-git-send-email-B45475@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-06-24 at 15:55 +0800, Zhao Qiang wrote:
> ret is unused when CONFIG_FSL_SOC defined,
> so include it with "#ifndef CONFIG_FSL_SOC".
> 
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
>  drivers/spi/spi-fsl-lib.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

This needs to be sent to the SPI list and maintainer.

-Scott
