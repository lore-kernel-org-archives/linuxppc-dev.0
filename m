Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D104BDDDE1
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 13:52:52 +1100 (EST)
Subject: Re: [PATCH] Format string bug in drivers/of/of_i2c.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <20081020121315.10428.10730.stgit@terra>
References: <20081020121315.10428.10730.stgit@terra>
Content-Type: text/plain
Date: Tue, 21 Oct 2008 13:52:45 +1100
Message-Id: <1224557565.7654.222.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-10-20 at 08:13 -0400, Jon Smirl wrote:
> Format string bug.  Not exploitable, as this is only writable by root,
> but worth fixing all the same.

Where is your signed-off-by ?

Cheers,
Ben.

> See 326f6a5c9c9e1a62aec37bdc0c3f8d53adabe77b
> ---
>  drivers/of/of_i2c.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
> index 6a98dc8..24bbef7 100644
> --- a/drivers/of/of_i2c.c
> +++ b/drivers/of/of_i2c.c
> @@ -41,7 +41,7 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
>  
>  		info.addr = *addr;
>  
> -		request_module(info.type);
> +		request_module("%s", info.type);
>  
>  		result = i2c_new_device(adap, &info);
>  		if (result == NULL) {
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
