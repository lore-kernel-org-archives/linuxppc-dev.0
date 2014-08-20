Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0210.outbound.protection.outlook.com [207.46.163.210])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 63D551A000C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 10:08:21 +1000 (EST)
Message-ID: <1408493285.4058.55.camel@snotra.buserror.net>
Subject: Re: [PATCH 2/2] fsl_ifc: Support all 8 IFC chip selects
From: Scott Wood <scottwood@freescale.com>
To: Aaron Sierra <asierra@xes-inc.com>
Date: Tue, 19 Aug 2014 19:08:05 -0500
In-Reply-To: <1234993482.57039.1408136876321.JavaMail.zimbra@xes-inc.com>
References: <1234993482.57039.1408136876321.JavaMail.zimbra@xes-inc.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, Prabhakar
 Kushwaha <prabhakar@freescale.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-08-15 at 16:07 -0500, Aaron Sierra wrote:
> Freescale's QorIQ T Series processors support 8 IFC chip selects
> within a memory map backward compatible with previous P Series
> processors which supported only 4 chip selects.
> 
> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
> ---
>  include/linux/fsl_ifc.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/fsl_ifc.h b/include/linux/fsl_ifc.h
> index 84d60cb..62762ff 100644
> --- a/include/linux/fsl_ifc.h
> +++ b/include/linux/fsl_ifc.h
> @@ -29,7 +29,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/interrupt.h>
>  
> -#define FSL_IFC_BANK_COUNT 4
> +#define FSL_IFC_BANK_COUNT 8

First please modify fsl_ifc_nand.c to limit itself to the number of
banks it dynamically determines are present based on the IFC version.

-Scott
