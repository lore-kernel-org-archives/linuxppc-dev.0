Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 58DCFDDEBA
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 02:28:17 +1100 (EST)
Message-ID: <47B06988.2010706@pobox.com>
Date: Mon, 11 Feb 2008 10:28:08 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Alexandre Bounine <Alexandre.Bounine@tundra.com>
Subject: Re: [PATCH 1/5] Tsi108_eth: add missing linking to driver data
References: <1B5F013528140F45B5C671039279CA5702A9609F@NANUK.pc.tundra.com>
In-Reply-To: <1B5F013528140F45B5C671039279CA5702A9609F@NANUK.pc.tundra.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alexandre Bounine wrote:
> Bug fix for tsi108_eth network driver.
> This patch adds missing linking to driver data. 
>    
> Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
> ---
> 
> diff -pNur linux-2.6.24/drivers/net/tsi108_eth.c
> linux-2.6.24-fix/drivers/net/tsi108_eth.c
> --- linux-2.6.24/drivers/net/tsi108_eth.c	2008-01-24
> 17:58:37.000000000 -0500
> +++ linux-2.6.24-fix/drivers/net/tsi108_eth.c	2008-02-06
> 14:30:04.000000000 -0500
> @@ -1629,6 +1629,7 @@ tsi108_init_one(struct platform_device *
>  		goto register_fail;
>  	}
>  
> +	platform_set_drvdata(pdev, dev);
>  	printk(KERN_INFO "%s: Tsi108 Gigabit Ethernet, MAC: %s\n",
>  	       dev->name, print_mac(mac, dev->dev_addr));
>  #ifdef DEBUG

ACK, but your patches are unusable because they are word-wrapped
