Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 19697DDE0A
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Dec 2007 08:36:03 +1100 (EST)
Message-ID: <4751D3BD.6020106@pobox.com>
Date: Sat, 01 Dec 2007 16:35:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] SET_NETDEV_DEV() in fec_mpc52xx.c
References: <1196273071.30806.46.camel@pmac.infradead.org>
In-Reply-To: <1196273071.30806.46.camel@pmac.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Domen Puncer <domen.puncer@telargo.com>,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse wrote:
> This helps to allow the Fedora installer to use the built-in Ethernet on
> the Efika for a network install.
> 
> Signed-off-by: David Woodhouse <dwmw2@infradead.org>
> 
> --- a/drivers/net/fec_mpc52xx.c
> +++ b/drivers/net/fec_mpc52xx.c
> @@ -971,6 +971,8 @@ mpc52xx_fec_probe(struct of_device *op, const struct of_device_id *match)
>  
>  	mpc52xx_fec_reset_stats(ndev);
>  
> +	SET_NETDEV_DEV(ndev, &op->dev);
> +
>  	/* Register the new network device */
>  	rv = register_netdev(ndev);

applied
