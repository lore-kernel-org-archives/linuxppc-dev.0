Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 141CBDDEC0
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 13:04:20 +1000 (EST)
Message-ID: <4719702C.7010004@pobox.com>
Date: Fri, 19 Oct 2007 23:04:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] Fix build break in tsi108.c
References: <20071020020420.GA20073@lixom.net>
In-Reply-To: <20071020020420.GA20073@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: joe@perches.com, netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> Fix build break:
> 
> drivers/net/tsi108_eth.c: In function 'tsi108_init_one':
> drivers/net/tsi108_eth.c:1633: error: expected ')' before 'dev'
> drivers/net/tsi108_eth.c:1633: warning: too few arguments for format
> make[2]: *** [drivers/net/tsi108_eth.o] Error 1
> 
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> diff --git a/drivers/net/tsi108_eth.c b/drivers/net/tsi108_eth.c
> index df10af7..35d15e8 100644
> --- a/drivers/net/tsi108_eth.c
> +++ b/drivers/net/tsi108_eth.c
> @@ -1629,7 +1629,7 @@ tsi108_init_one(struct platform_device *pdev)
>  		goto register_fail;
>  	}
>  
> -	printk(KERN_INFO "%s: Tsi108 Gigabit Ethernet, MAC: %s\n"
> +	printk(KERN_INFO "%s: Tsi108 Gigabit Ethernet, MAC: %s\n",
>  	       dev->name, print_mac(mac, dev->dev_addr));
>  #ifdef DEBUG

applied
