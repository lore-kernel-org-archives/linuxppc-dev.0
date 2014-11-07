Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0110.outbound.protection.outlook.com [157.56.111.110])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 533F91A00B5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Nov 2014 15:08:03 +1100 (AEDT)
Message-ID: <1415333263.23458.417.camel@snotra.buserror.net>
Subject: Re: [PATCH v2 0/3] fix a kernel panic on fsl corenet board when
 CONFIG_CLK_PPC_CORENET is enabled
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
Date: Thu, 6 Nov 2014 22:07:43 -0600
In-Reply-To: <1413699099-25743-1-git-send-email-haokexin@gmail.com>
References: <1413699099-25743-1-git-send-email-haokexin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Mike Turquette <mturquette@linaro.org>, Gerhard Sittig <gsi@denx.de>,
 Jingchang Lu <jingchang.lu@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2014-10-19 at 14:11 +0800, Kevin Hao wrote:
> Hi,
> 
> I have done a boot test on p2014rdb and t4240qds boards. I don't have an access
> to mpc512x board, so only build test for that.
> 
> v2:
>  - Revert the commit da788acb2838 first.
>  - Invoke of_clk_init() from a common place.
> 
> v1
> This tries to fix a kernel panic introduced by commit da788acb2838
> ("clk: ppc-corenet: Fix Section mismatch warning").
> 
> Kevin Hao (3):
>   Revert "clk: ppc-corenet: Fix Section mismatch warning"
>   powerpc: call of_clk_init() from time_init()
>   clk: ppc-corenet: fix section mismatch warning
> 
>  arch/powerpc/kernel/time.c                    |  5 ++++
>  arch/powerpc/platforms/512x/clock-commonclk.c | 11 ++++---
>  drivers/clk/clk-ppc-corenet.c                 | 43 ++++-----------------------
>  3 files changed, 16 insertions(+), 43 deletions(-)
> 

Acked-by: Scott Wood <scottwood@freescale.com>

Whose tree should this go through?

-Scott
