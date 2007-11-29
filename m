Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 43982DDEB6
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 07:55:14 +1100 (EST)
Subject: Re: [PATCH 5/5] PPC cleanup: powermac - do use for_each macro
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Cyrill Gorcunov <gorcunov@gmail.com>
In-Reply-To: <20071129194654.GF12123@cvg>
References: <20071129194654.GF12123@cvg>
Content-Type: text/plain
Date: Fri, 30 Nov 2007 07:54:59 +1100
Message-Id: <1196369699.13230.62.camel@pasglop>
Mime-Version: 1.0
Cc: PPCML <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	LKML <linux-kernel@vger.kernel.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-11-29 at 22:46 +0300, Cyrill Gorcunov wrote:
> From: Cyrill Gorcunov <gorcunov@gmail.com>
> 
> Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
> ---

Ack.

>  arch/powerpc/platforms/powermac/low_i2c.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
> index da2007e..864fbf4 100644
> --- a/arch/powerpc/platforms/powermac/low_i2c.c
> +++ b/arch/powerpc/platforms/powermac/low_i2c.c
> @@ -585,8 +585,7 @@ static void __init kw_i2c_probe(void)
>  	struct device_node *np, *child, *parent;
>  
>  	/* Probe keywest-i2c busses */
> -	for (np = NULL;
> -	     (np = of_find_compatible_node(np, "i2c","keywest-i2c")) != NULL;){
> +	for_each_compatible_node(np, "i2c","keywest-i2c") {
>  		struct pmac_i2c_host_kw *host;
>  		int multibus, chans, i;
>  
