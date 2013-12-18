Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C7FC72C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 06:53:20 +1100 (EST)
Date: Wed, 18 Dec 2013 20:53:15 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v1 0/4] powerpc/512x: update COMMON_CLK support for MPC5125
Message-ID: <20131218205315.2431b5db@crub>
In-Reply-To: <1386681097-14126-1-git-send-email-gsi@denx.de>
References: <1386681097-14126-1-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Mike Turquette <mturquette@linaro.org>, Detlev Zundel <dzu@denx.de>,
 Matteo Facchinetti <matteo.facchinetti@sirius-es.it>,
 Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 10 Dec 2013 14:11:33 +0100
Gerhard Sittig <gsi@denx.de> wrote:
...
> Gerhard Sittig (4):
>   powerpc/512x: clk: minor comment updates
>   powerpc/512x: clk: enforce even SDHC divider values
>   powerpc/512x: clk: support MPC5121/5123/5125 SoC variants
>   powerpc/512x: dts: add MPC5125 clock specs
> 
>  arch/powerpc/boot/dts/mpc5125twr.dts          |   53 +++-
>  arch/powerpc/include/asm/mpc5121.h            |    7 +-
>  arch/powerpc/platforms/512x/clock-commonclk.c |  369 +++++++++++++++++++++----
>  include/dt-bindings/clock/mpc512x-clock.h     |    9 +-
>  4 files changed, 386 insertions(+), 52 deletions(-)

Applied this series to mpc5xxx next. Thanks!

Anatolij
