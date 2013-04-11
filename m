Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9B29B2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 23:21:36 +1000 (EST)
Subject: Re: [PATCH 0/2] enable the coreint for the mpc85xx 64bit boards 
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1365643954-20798-1-git-send-email-haokexin@gmail.com>
Date: Thu, 11 Apr 2013 08:21:24 -0500
Message-Id: <6DEE94C2-19EB-487D-99B5-58789C9230BF@kernel.crashing.org>
References: <1365643954-20798-1-git-send-email-haokexin@gmail.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Cc: Kevin Hao <haokexin@gmail.com>, linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 10, 2013, at 8:32 PM, Kevin Hao wrote:

> Hi,
> 
> With the rework of the lazy EE, it seems that 64bit kernel works pretty
> well on mpc85xx 64bit boards with lazy EE enabled. So this patch series
> tries to enable the coreint for these boards by default. This passed
> the ltp test on a t4240qds board and is based on Kumar's next branch.
> 
> ---
> Kevin Hao (2):
>  powerpc/irq: remove the unneeded flag PACA_IRQ_EE_EDGE
>  powerpc/85xx: enable coreint for all the 64bit boards
> 
> arch/powerpc/include/asm/hw_irq.h       | 1 -
> arch/powerpc/kernel/exceptions-64e.S    | 1 -
> arch/powerpc/kernel/irq.c               | 8 --------
> arch/powerpc/platforms/85xx/p5020_ds.c  | 5 -----
> arch/powerpc/platforms/85xx/p5040_ds.c  | 5 -----
> arch/powerpc/platforms/85xx/t4240_qds.c | 5 -----
> 6 files changed, 25 deletions(-)

Scott,

I'd appreciate your review and ack on this change.

thanks

- k
