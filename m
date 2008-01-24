Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1E4A4DDDFA
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 12:20:19 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0O1KGFt021146
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 20:20:16 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0O1KGGR162642
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 20:20:16 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0O1KGZV019758
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 20:20:16 -0500
Date: Wed, 23 Jan 2008 19:17:04 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Roel Kluin <12o3l@tiscali.nl>
Subject: Re: [PATCH][ppc] logical/bitand typo in powerpc/boot/4xx.c
Message-ID: <20080123191704.2d74073a@zod.rchland.ibm.com>
In-Reply-To: <4797C1AD.3040307@tiscali.nl>
References: <4797C1AD.3040307@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, sr@denx.de, lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 23 Jan 2008 23:37:33 +0100
Roel Kluin <12o3l@tiscali.nl> wrote:

> logical/bitand typo
> 
> Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
> ---
> diff --git a/arch/powerpc/boot/4xx.c b/arch/powerpc/boot/4xx.c
> index ebf9e21..dcfb459 100644
> --- a/arch/powerpc/boot/4xx.c
> +++ b/arch/powerpc/boot/4xx.c
> @@ -104,7 +104,7 @@ void ibm4xx_denali_fixup_memsize(void)
>  	val = DDR_GET_VAL(val, DDR_CS_MAP, DDR_CS_MAP_SHIFT);
>  	cs = 0;
>  	while (val) {
> -		if (val && 0x1)
> +		if (val & 0x1)
>  			cs++;
>  		val = val >> 1;
>  	}

Hm, good catch.

Stefan, have you had problems with this code at all?

josh
