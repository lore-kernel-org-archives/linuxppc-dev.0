Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 83AB1DDED0
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 16:37:31 +1000 (EST)
Message-ID: <48648AA2.2020204@garzik.org>
Date: Fri, 27 Jun 2008 02:37:22 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 01/12] pata_mpc52xx: use linux/of_platform.h instead of asm
References: <20080523161627.a75d5010.sfr@canb.auug.org.au>
In-Reply-To: <20080523161627.a75d5010.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Tejun Heo <htejun@gmail.com>,
	Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/ata/pata_mpc52xx.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> I am not sure who wants to take this.
> 
> diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
> index bc79df6..a9e8273 100644
> --- a/drivers/ata/pata_mpc52xx.c
> +++ b/drivers/ata/pata_mpc52xx.c
> @@ -16,10 +16,10 @@
>  #include <linux/slab.h>
>  #include <linux/delay.h>
>  #include <linux/libata.h>
> +#include <linux/of_platform.h>
>  
>  #include <asm/types.h>
>  #include <asm/prom.h>
> -#include <asm/of_platform.h>
>  #include <asm/mpc52xx.h>

ACK.  send it via an arch tree
