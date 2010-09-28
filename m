Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 54978B713B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Sep 2010 23:09:28 +1000 (EST)
To: Ilya Yanok <yanok@emcraft.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 3/3] mpc512x_dma: add MPC8308 support
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <1285676696-5358-4-git-send-email-yanok@emcraft.com>
References: <1285676696-5358-1-git-send-email-yanok@emcraft.com>
	<1285676696-5358-4-git-send-email-yanok@emcraft.com>
Date: Tue, 28 Sep 2010 15:09:19 +0200
Message-Id: <20100928130919.1558AD5218F@gemini.denx.de>
Cc: vlad@emcraft.com, linuxppc-dev@lists.ozlabs.org,
	Piotr Ziecik <kosmo@semihalf.com>, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Ilya Yanok,

In message <1285676696-5358-4-git-send-email-yanok@emcraft.com> you wrote:
> MPC8308 has pretty much the same DMA controller as MPC5121 and
> this patch adds support for MPC8308 to the mpc512x_dma driver.
> 
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> Cc: Piotr Ziecik <kosmo@semihalf.com>
> ---
>  drivers/dma/Kconfig       |    2 +-
>  drivers/dma/mpc512x_dma.c |   95 +++++++++++++++++++++++++++++++++-----------
>  2 files changed, 72 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 9520cf0..5c5e95b 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -100,7 +100,7 @@ config FSL_DMA
>  
>  config MPC512X_DMA
>  	tristate "Freescale MPC512x built-in DMA engine support"
> -	depends on PPC_MPC512x
> +	depends on PPC_MPC512x || PPC_MPC831x

Is MPC831x correct here? My understanding is that MPC831x processors
have yet other DMA cotnrollers, and we're on a MPC8308 here?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"A little knowledge is a dangerous thing."                - Doug Gwyn
