Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2B295DDF4E
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 06:09:57 +1000 (EST)
Message-ID: <48863E8E.4080308@pobox.com>
Date: Tue, 22 Jul 2008 16:09:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH] fs_enet: Remove unused fields in the
	fs_mii_bb_platform_info structure.
References: <200807221743.47807.laurentp@cse-semaphore.com>
In-Reply-To: <200807221743.47807.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, vbordug@ru.mvista.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Laurent Pinchart wrote:
> The mdio_port, mdio_bit, mdc_port and mdc_bit fields in the
> fs_mii_bb_platform_info structure are left-overs from the move to the Phy
> Abstraction Layer subsystem. They are not used anymore and can be safely
> removed.
> 
> Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
> ---
>  include/linux/fs_enet_pd.h    |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/fs_enet_pd.h b/include/linux/fs_enet_pd.h
> index 9bc045b..decc4b5 100644
> --- a/include/linux/fs_enet_pd.h
> +++ b/include/linux/fs_enet_pd.h
> @@ -103,10 +103,6 @@ struct fs_mii_bb_platform_info {
>  	struct fs_mii_bit 	mdio_dir;
>  	struct fs_mii_bit 	mdio_dat;
>  	struct fs_mii_bit	mdc_dat;
> -	int mdio_port;	/* port & bit for MDIO */
> -	int mdio_bit;
> -	int mdc_port;	/* port & bit for MDC  */
> -	int mdc_bit;
>  	int delay;	/* delay in us         */
>  	int irq[32]; 	/* irqs per phy's */

applied
