Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id CFC7767BD9
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Nov 2006 21:29:55 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [POWERPC] We should only execute init_spu_base on cell
Date: Mon, 27 Nov 2006 11:29:41 +0100
References: <20061127175955.a5a668cc.sfr@canb.auug.org.au>
In-Reply-To: <20061127175955.a5a668cc.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611271129.42273.arnd@arndb.de>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 27 November 2006 07:59, Stephen Rothwell wrote:
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

> diff --git a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/platforms/cell/spu_base.c
> index 841ed35..bd7bffc 100644
> --- a/arch/powerpc/platforms/cell/spu_base.c
> +++ b/arch/powerpc/platforms/cell/spu_base.c
> @@ -663,6 +663,9 @@ static int __init init_spu_base(void)
>  {
>  	int i, ret;
>  
> +	if (!spu_management_ops)
> +		return 0;
> +
>  	/* create sysdev class for spus */
>  	ret = sysdev_class_register(&spu_sysdev_class);
>  	if (ret)

Looks good, thanks.

	Arnd <><
