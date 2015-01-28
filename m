Return-Path: <mturquette@linaro.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A725E1A0C37
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 05:15:21 +1100 (AEDT)
Received: by mail-pa0-f51.google.com with SMTP id fb1so28218194pad.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 10:15:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Emil Medve <Emilian.Medve@Freescale.com>, linuxppc-dev@lists.ozlabs.org,
 scottwood@Freescale.com, haokexin@gmail.com, yuantian.tang@Freescale.com
From: Mike Turquette <mturquette@linaro.org>
In-Reply-To: <1421834611-9656-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1421834611-9656-1-git-send-email-Emilian.Medve@Freescale.com>
Message-ID: <20150128181504.22722.30981@quantum>
Subject: Re: [PATCH v2 00/10] clk: qoriq: Add support for the FMan clock
Date: Wed, 28 Jan 2015 10:15:04 -0800
Cc: Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Quoting Emil Medve (2015-01-21 02:03:22)
> Based on clk-next from git://git.kernel.org/pub/scm/linux/kernel/git/clk/=
linux.git
> =

> v2:     Rebased as several prerequisite patches (including a file rename)=
 got
>         applied upstream
> =

> Emil Medve (9):
>   clk: qoriq: Fix checkpatch type PARENTHESIS_ALIGNMENT
>   clk: qoriq: Fix checkpatch type ALLOC_WITH_MULTIPLY
>   clk: qoriq: Fix checkpatch type ALLOC_SIZEOF_STRUCT
>   clk: qoriq: Fix checkpatch type OOM_MESSAGE
>   clk: qoriq: Make local symbol 'static'
>   clk: qoriq: Replace kzalloc() with kmalloc()
>   clk: qoriq: Use pr_fmt()

Patches 1-7 applied to clk-next towards 3.20. I'd prefer some
reviewed-by's from your peers at freescale for the clock driver
correctness.

Thanks,
Mike

>   powerpc/corenet: Enable CLK_QORIQ
>   clk: qoriq: Add support for the platform PLL
> =

> Igal Liberman (1):
>   clk: qoriq: Add support for the FMan clock
> =

>  arch/powerpc/configs/corenet32_smp_defconfig |   1 +
>  arch/powerpc/configs/corenet64_smp_defconfig |   1 +
>  drivers/clk/clk-qoriq.c                      | 378 +++++++++++++++++++++=
++++--
>  3 files changed, 357 insertions(+), 23 deletions(-)
> =

> -- =

> 2.2.1
