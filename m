Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AD64BDDE28
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 09:14:28 +1100 (EST)
Message-ID: <498A1315.5060200@freescale.com>
Date: Wed, 04 Feb 2009 16:13:41 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Julia Lawall <julia@diku.dk>
Subject: Re: [PATCH] arch/powerpc: Eliminate double sizeof
References: <Pine.LNX.4.64.0902042236200.3091@ask.diku.dk>
In-Reply-To: <Pine.LNX.4.64.0902042236200.3091@ask.diku.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Julia Lawall wrote:
> Signed-off-by: Julia Lawall <julia@diku.dk>
> ---
>  arch/powerpc/platforms/82xx/pq2ads-pci-pic.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -u -p a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
> --- a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
> +++ b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
> @@ -186,7 +186,7 @@ out_unmap_regs:
>  	iounmap(priv->regs);
>  out_free_bootmem:
>  	free_bootmem((unsigned long)priv,
> -	             sizeof(sizeof(struct pq2ads_pci_pic)));
> +	             sizeof(struct pq2ads_pci_pic));
>  	of_node_put(np);
>  out_unmap_irq:
>  	irq_dispose_mapping(irq);

ACK

-Scott
