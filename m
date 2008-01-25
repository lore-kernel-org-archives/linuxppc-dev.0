Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8A028DDF9C
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 11:46:03 +1100 (EST)
Date: Fri, 25 Jan 2008 15:23:32 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 5/9] powerpc: ipic: add interrupt vector 94
In-Reply-To: <20080124204650.48578c7f.kim.phillips@freescale.com>
Message-ID: <Pine.LNX.4.64.0801251523110.20972@blarg.am.freescale.net>
References: <20080124204650.48578c7f.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Jerry Huang <Chang-Ming.Huang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 24 Jan 2008, Kim Phillips wrote:

> this is used on the mpc8315 SoC for DMA error interrupts.
>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
>  arch/powerpc/sysdev/ipic.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>

applied.  (fyi, the irq is for TDM DMA, not general DMA)

- k
