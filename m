Return-Path: <mturquette@linaro.org>
Received: from mail-pd0-f176.google.com (mail-pd0-f176.google.com
 [209.85.192.176])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5619E1A0791
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 13:38:32 +1100 (AEDT)
Received: by mail-pd0-f176.google.com with SMTP id y10so2112874pdj.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 18:38:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, "Kevin Hao" <haokexin@gmail.com>
From: Mike Turquette <mturquette@linaro.org>
In-Reply-To: <1415333263.23458.417.camel@snotra.buserror.net>
References: <1413699099-25743-1-git-send-email-haokexin@gmail.com>
 <1415333263.23458.417.camel@snotra.buserror.net>
Message-ID: <20141120023825.12298.29691@quantum>
Subject: Re: [PATCH v2 0/3] fix a kernel panic on fsl corenet board when
 CONFIG_CLK_PPC_CORENET is enabled
Date: Wed, 19 Nov 2014 18:38:25 -0800
Cc: Gerhard Sittig <gsi@denx.de>, linuxppc-dev@lists.ozlabs.org,
 Jingchang Lu <jingchang.lu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Quoting Scott Wood (2014-11-06 20:07:43)
> On Sun, 2014-10-19 at 14:11 +0800, Kevin Hao wrote:
> > Hi,
> > =

> > I have done a boot test on p2014rdb and t4240qds boards. I don't have a=
n access
> > to mpc512x board, so only build test for that.
> > =

> > v2:
> >  - Revert the commit da788acb2838 first.
> >  - Invoke of_clk_init() from a common place.
> > =

> > v1
> > This tries to fix a kernel panic introduced by commit da788acb2838
> > ("clk: ppc-corenet: Fix Section mismatch warning").
> > =

> > Kevin Hao (3):
> >   Revert "clk: ppc-corenet: Fix Section mismatch warning"
> >   powerpc: call of_clk_init() from time_init()
> >   clk: ppc-corenet: fix section mismatch warning
> > =

> >  arch/powerpc/kernel/time.c                    |  5 ++++
> >  arch/powerpc/platforms/512x/clock-commonclk.c | 11 ++++---
> >  drivers/clk/clk-ppc-corenet.c                 | 43 ++++---------------=
--------
> >  3 files changed, 16 insertions(+), 43 deletions(-)
> > =

> =

> Acked-by: Scott Wood <scottwood@freescale.com>

I'm fine with it going through the ppc tree.

Acked-by: Michael Turquette <mturquette@linaro.org>

> =

> Whose tree should this go through?
> =

> -Scott
> =

>=20
