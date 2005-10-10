Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 08949684C7
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Oct 2005 08:19:57 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20051010201117.GB14317@suse.de>
References: <20051010200739.GA14317@suse.de> <20051010201117.GB14317@suse.de>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 08:16:31 +1000
Message-Id: <1128982591.17365.167.camel@gaston>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Add modalias for pmac network drivers
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-10-10 at 22:11 +0200, Olaf Hering wrote:
> mesh, mac53c94 and airport already have an entry.
> Add the network drivers for pmac.
> 
> Signed-off-by: Olaf Hering <olh@suse.de>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

>  drivers/net/bmac.c                   |    1 +
>  drivers/net/mace.c                   |    1 +
> 
> Index: linux-2.6.12/drivers/net/bmac.c
> ===================================================================
> --- linux-2.6.12.orig/drivers/net/bmac.c
> +++ linux-2.6.12/drivers/net/bmac.c
> @@ -1658,6 +1658,7 @@ static struct of_device_id bmac_match[] 
>  	},
>  	{},
>  };
> +MODULE_DEVICE_TABLE (of, bmac_match);
>  
>  static struct macio_driver bmac_driver = 
>  {
> Index: linux-2.6.12/drivers/net/mace.c
> ===================================================================
> --- linux-2.6.12.orig/drivers/net/mace.c
> +++ linux-2.6.12/drivers/net/mace.c
> @@ -1016,6 +1016,7 @@ static struct of_device_id mace_match[] 
>  	},
>  	{},
>  };
> +MODULE_DEVICE_TABLE (of, mace_match);
>  
>  static struct macio_driver mace_driver = 
>  {
> 
