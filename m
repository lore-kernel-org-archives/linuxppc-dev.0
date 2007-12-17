Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9C67CDDDEA
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Dec 2007 10:25:00 +1100 (EST)
Message-ID: <47670547.7000701@pobox.com>
Date: Mon, 17 Dec 2007 18:24:55 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] [POWERPC] pasemi: export pasemi_dma_init()
References: <20071214080655.GA27284@lixom.net>
In-Reply-To: <20071214080655.GA27284@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> Forgot to export this one. Needed when pasemi_mac is compiled as a module.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> ---
> 
> Jeff, since the dma_lib stuff went up through netdev-2.6, please apply and
> feed this one up with the rest.
> 
> 
> Thanks,
> 
> Olof
> 
> Index: 2.6.24/arch/powerpc/platforms/pasemi/dma_lib.c
> ===================================================================
> --- 2.6.24.orig/arch/powerpc/platforms/pasemi/dma_lib.c
> +++ 2.6.24/arch/powerpc/platforms/pasemi/dma_lib.c
> @@ -485,3 +485,4 @@ out:
>  	spin_unlock(&init_lock);
>  	return err;
>  }
> +EXPORT_SYMBOL(pasemi_dma_init);

For .24 (#upstream-fixes) or .25 (#upstream)?

	Jeff
