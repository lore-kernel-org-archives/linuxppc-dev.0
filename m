Return-Path: <scottwood@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7A4342C00C1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Nov 2013 12:51:09 +1100 (EST)
Message-ID: <1384307459.1403.120.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/3] powerpc/p1010rdb:add P1010RDB-PB platform support
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang <B45475@freescale.com>
Date: Tue, 12 Nov 2013 19:50:59 -0600
In-Reply-To: <1383791369-29324-1-git-send-email-B45475@freescale.com>
References: <1383791369-29324-1-git-send-email-B45475@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: tony@atomide.com, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bcousson@baylibre.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-11-07 at 10:29 +0800, Zhao Qiang wrote:
> The P1010RDB-PB is similar to P1010RDB(P1010RDB-PA).
> So, P1010RDB-PB use the same platform file as P1010RDB.
> Then Add support for P1010RDB-PB platform.
> 
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
>  arch/powerpc/platforms/85xx/p1010rdb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/85xx/p1010rdb.c b/arch/powerpc/platforms/85xx/p1010rdb.c
> index 0252961..d6a3dd3 100644
> --- a/arch/powerpc/platforms/85xx/p1010rdb.c
> +++ b/arch/powerpc/platforms/85xx/p1010rdb.c
> @@ -66,6 +66,8 @@ static int __init p1010_rdb_probe(void)
>  
>  	if (of_flat_dt_is_compatible(root, "fsl,P1010RDB"))
>  		return 1;
> +	if (of_flat_dt_is_compatible(root, "fsl,P1010RDB-PB"))
> +		return 1;
>  	return 0;
>  }
>  

This had already been merged into Ben's tree when you reposted it
(without any indication that it was a repost/respin), and is now in
Linus's tree.

-Scott
