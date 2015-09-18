Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E78211A2C01
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 16:52:17 +1000 (AEST)
Date: Fri, 18 Sep 2015 08:36:18 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, kernel@pengutronix.de
Subject: Re: [PATCH] powerpc: mpc512x: drop bogus and unused psc register bit
 definitions
Message-ID: <20150918063618.GS5327@pengutronix.de>
References: <1437463273-24742-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1437463273-24742-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Tue, Jul 21, 2015 at 09:21:13AM +0200, Uwe Kleine-König wrote:
> These were introduced in commit 25ae3a0739c6 ("[POWERPC] mpc512x: Add
> MPC512x PSC support to MPC52xx psc driver") and never used. Moreover
> according to the datasheet[1] MEMERROR is bit 25 (0x40) and ORERR is
> bit 27 (0x10).
> 
> [1] MPC5125RM Rev. 2; 11/2009

I didn't get any feedback for this patch yet. Do you still consider it?

Best regards
Uwe

> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  arch/powerpc/include/asm/mpc52xx_psc.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/mpc52xx_psc.h b/arch/powerpc/include/asm/mpc52xx_psc.h
> index d0ece257d310..92806c24c2c5 100644
> --- a/arch/powerpc/include/asm/mpc52xx_psc.h
> +++ b/arch/powerpc/include/asm/mpc52xx_psc.h
> @@ -258,8 +258,6 @@ struct mpc52xx_psc_fifo {
>  #define MPC512x_PSC_FIFO_FULL		0x2
>  #define MPC512x_PSC_FIFO_ALARM		0x4
>  #define MPC512x_PSC_FIFO_URERR		0x8
> -#define MPC512x_PSC_FIFO_ORERR		0x01
> -#define MPC512x_PSC_FIFO_MEMERROR	0x02
>  
>  struct mpc512x_psc_fifo {
>  	u32		reserved1[10];

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
