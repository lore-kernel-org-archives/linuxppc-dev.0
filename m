Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3173BDDFB7
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 11:46:04 +1100 (EST)
Date: Fri, 25 Jan 2008 15:24:13 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 7/9] powerpc: add MPC837x RDB platform support
In-Reply-To: <20080124204711.02ba14f0.kim.phillips@freescale.com>
Message-ID: <Pine.LNX.4.64.0801251524010.20972@blarg.am.freescale.net>
References: <20080124204711.02ba14f0.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Joe D'Abbraccio <ljd015@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 24 Jan 2008, Kim Phillips wrote:

> primarily based on mpc837x mds code.
>
> Signed-off-by: Joe D'Abbraccio <ljd015@freescale.com>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
>  arch/powerpc/platforms/83xx/Kconfig       |    8 ++-
>  arch/powerpc/platforms/83xx/Makefile      |    1 +
>  arch/powerpc/platforms/83xx/mpc837x_rdb.c |   99 +++++++++++++++++++++++++++++
>  3 files changed, 107 insertions(+), 1 deletions(-)
>  create mode 100644 arch/powerpc/platforms/83xx/mpc837x_rdb.c
>

applied.

- k
