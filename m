Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C27BCDE03D
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Sep 2008 09:14:09 +1000 (EST)
Message-ID: <48CC4933.2060507@garzik.org>
Date: Sat, 13 Sep 2008 19:13:55 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Hannes Hering <hannes.hering@gmx.de>
Subject: Re: [PATCH 2/2] ehea: Enable DLPAR memory remove
References: <200809051638.22160.hannes.hering@gmx.de>
In-Reply-To: <200809051638.22160.hannes.hering@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: themann@de.ibm.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	raisch@de.ibm.com, ossrosch@linux.vnet.ibm.com,
	linuxppc-dev@ozlabs.org, ossthema@de.ibm.com, osstklei@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hannes Hering wrote:
> This patch adds the capability flag to the capability list for dynamic LPAR
> memory remove to enable this feature.
> 
> Signed-off-by: Hannes Hering <hering2@de.ibm.com>
> ---
> 
> diff -Nurp -X dontdiff linux-2.6.27-rc5/drivers/net/ehea/ehea.h patched_kernel/drivers/net/ehea/ehea.h
> --- linux-2.6.27-rc5/drivers/net/ehea/ehea.h	2008-08-29 00:52:02.000000000 +0200
> +++ patched_kernel/drivers/net/ehea/ehea.h	2008-09-05 15:33:12.000000000 +0200
> @@ -40,13 +40,13 @@
>  #include <asm/io.h>
>  
>  #define DRV_NAME	"ehea"
> -#define DRV_VERSION	"EHEA_0092"
> +#define DRV_VERSION	"EHEA_0093"
>  
>  /* eHEA capability flags */
>  #define DLPAR_PORT_ADD_REM 1
>  #define DLPAR_MEM_ADD      2
>  #define DLPAR_MEM_REM      4
> -#define EHEA_CAPABILITIES  (DLPAR_PORT_ADD_REM | DLPAR_MEM_ADD)
> +#define EHEA_CAPABILITIES  (DLPAR_PORT_ADD_REM | DLPAR_MEM_ADD | DLPAR_MEM_REM)

applied
