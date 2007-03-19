Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BA08FDDF44
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 03:04:21 +1100 (EST)
Message-ID: <45FEB47D.1090906@garzik.org>
Date: Mon, 19 Mar 2007 12:04:13 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: Re: [PATCH] drivers/ata/Kconfig: PATA_SCC depends on wrong platform
References: <200703150530.l2F5Uwel024855@toshiba.co.jp>
In-Reply-To: <200703150530.l2F5Uwel024855@toshiba.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Akira Iguchi wrote:
> PATA_SCC depends on PPC_CELLEB. (not PPC_IBM_CELL_BLADE)
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
> ---
> 
> diff -Nrpu -X linux-2.6.21-rc3/Documentation/dontdiff linux-2.6.21-rc3/drivers/ata/Kconfig linux-2.6.21-rc3.mod/drivers/ata/Kconfig
> --- linux-2.6.21-rc3/drivers/ata/Kconfig	2007-03-07 13:41:20.000000000 +0900
> +++ linux-2.6.21-rc3.mod/drivers/ata/Kconfig	2007-03-15 23:04:14.000000000 +0900
> @@ -564,7 +564,7 @@ config PATA_IXP4XX_CF
>  
>  config PATA_SCC
>  	tristate "Toshiba's Cell Reference Set IDE support"
> -	depends on PCI && PPC_IBM_CELL_BLADE
> +	depends on PCI && PPC_CELLEB
>  	help
>  	  This option enables support for the built-in IDE controller on

aplied
