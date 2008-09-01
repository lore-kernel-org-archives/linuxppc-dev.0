Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A2A7FDDE1C
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Sep 2008 10:38:10 +1000 (EST)
Subject: Re: [PATCH] ibm_newemac: MAL[12]_IER_EVENTS definition: 2x *_OTE
	-> *_DE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: roel kluin <roel.kluin@gmail.com>
In-Reply-To: <48B9B218.6060506@gmail.com>
References: <48B9B218.6060506@gmail.com>
Content-Type: text/plain
Date: Mon, 01 Sep 2008 10:30:47 +1000
Message-Id: <1220229047.13162.405.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	david@gibson.dropbear.id.au
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2008-08-30 at 22:48 +0200, roel kluin wrote:
> MAL[12]_IER_EVENTS definitions have MAL_IER_OTE twice
> but lack MAL_IER_DE
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>

Thanks.

> ---
>  drivers/net/ibm_newemac/mal.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ibm_newemac/mal.h b/drivers/net/ibm_newemac/mal.h
> index eaa7262..717dc38 100644
> --- a/drivers/net/ibm_newemac/mal.h
> +++ b/drivers/net/ibm_newemac/mal.h
> @@ -102,7 +102,7 @@
>  /* MAL V1 IER bits */
>  #define   MAL1_IER_NWE		0x00000008
>  #define   MAL1_IER_SOC_EVENTS	MAL1_IER_NWE
> -#define   MAL1_IER_EVENTS	(MAL1_IER_SOC_EVENTS | MAL_IER_OTE | \
> +#define   MAL1_IER_EVENTS	(MAL1_IER_SOC_EVENTS | MAL_IER_DE | \
>  				 MAL_IER_OTE | MAL_IER_OE | MAL_IER_PE)
>  
>  /* MAL V2 IER bits */
> @@ -110,7 +110,7 @@
>  #define   MAL2_IER_PRE		0x00000040
>  #define   MAL2_IER_PWE		0x00000020
>  #define   MAL2_IER_SOC_EVENTS	(MAL2_IER_PT | MAL2_IER_PRE | MAL2_IER_PWE)
> -#define   MAL2_IER_EVENTS	(MAL2_IER_SOC_EVENTS | MAL_IER_OTE | \
> +#define   MAL2_IER_EVENTS	(MAL2_IER_SOC_EVENTS | MAL_IER_DE | \
>  				 MAL_IER_OTE | MAL_IER_OE | MAL_IER_PE)
>  
> 
