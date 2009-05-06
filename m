Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 25D24DDFAF
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 06:30:09 +1000 (EST)
Message-ID: <4A01F33B.2090100@freescale.com>
Date: Wed, 06 May 2009 15:29:47 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 04/12] mpc5121: Added reset module registers
	representation.
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-5-git-send-email-wd@denx.de>
In-Reply-To: <1241640919-4650-5-git-send-email-wd@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Denk wrote:
> From: Piotr Ziecik <kosmo@semihalf.com>
> 
> Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: John Rigby <jcrigby@gmail.com>
> ---
>  arch/powerpc/include/asm/mpc512x.h |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/mpc512x.h b/arch/powerpc/include/asm/mpc512x.h
> index c48a165..ea50d8d 100644
> --- a/arch/powerpc/include/asm/mpc512x.h
> +++ b/arch/powerpc/include/asm/mpc512x.h
> @@ -16,6 +16,19 @@
>  #ifndef __ASM_POWERPC_MPC512x_H__
>  #define __ASM_POWERPC_MPC512x_H__
>  
> +/* MPC512x Reset module registers */
> +struct mpc512x_reset_module {
> +	u32	rcwlr;	/* Reset Configuration Word Low Register */
> +	u32	rcwhr;	/* Reset Configuration Word High Register */
> +	u32	reserved1;
> +	u32	reserved2;
> +	u32	rsr;	/* Reset Status Register */
> +	u32	rmr;	/* Reset Mode Register */
> +	u32	rpr;	/* Reset Protection Register */
> +	u32	rcr;	/* Reset Control Register */
> +	u32	rcer;	/* Reset Control Enable Register */
> +} __attribute__ ((__packed__));
> +

83xx has the same registers; we should define it in a non-512x-specific 
header.

-Scott
