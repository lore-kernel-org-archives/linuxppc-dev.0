Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 966CADDE3C
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Dec 2007 06:42:15 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBHJgAni010379
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Dec 2007 14:42:10 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBHJg24H214948
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Dec 2007 12:42:04 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBHJfrS0026755
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Dec 2007 12:41:53 -0700
Date: Mon, 17 Dec 2007 13:36:58 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] arch/powerpc/: Spelling fixes
Message-ID: <20071217133658.3973000c@zod.rchland.ibm.com>
In-Reply-To: <1197919875-5288-13-git-send-email-joe@perches.com>
References: <1197919875-5288-13-git-send-email-joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: anton@au1.ibm.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, paulus@au1.ibm.com,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 17 Dec 2007 11:30:12 -0800
Joe Perches <joe@perches.com> wrote:

> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/powerpc/boot/4xx.c                 |    2 +-
>  arch/powerpc/kernel/legacy_serial.c     |    2 +-
>  arch/powerpc/sysdev/bestcomm/bestcomm.h |    2 +-
>  arch/powerpc/sysdev/mmio_nvram.c        |    2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/boot/4xx.c b/arch/powerpc/boot/4xx.c
> index ebf9e21..3d0e4f9 100644
> --- a/arch/powerpc/boot/4xx.c
> +++ b/arch/powerpc/boot/4xx.c
> @@ -122,7 +122,7 @@ void ibm4xx_denali_fixup_memsize(void)
>  	else
>  		dpath = 4; /* 32 bits */
> 
> -	/* get adress pins (rows) */
> +	/* get address pins (rows) */
>  	val = mfdcr_sdram0(DDR0_42);
> 
>  	row = DDR_GET_VAL(val, DDR_APIN, DDR_APIN_SHIFT);

Ack on this part.

josh
