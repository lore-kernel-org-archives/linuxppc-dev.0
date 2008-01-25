Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CBC13DDE1E
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 11:45:51 +1100 (EST)
Date: Fri, 25 Jan 2008 15:21:50 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 2/9] powerpc: add base platform support for the mpc8315
	rdb board
In-Reply-To: <20080124204600.d16c5142.kim.phillips@freescale.com>
Message-ID: <Pine.LNX.4.64.0801251521410.20972@blarg.am.freescale.net>
References: <20080124204600.d16c5142.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 24 Jan 2008, Kim Phillips wrote:

> mpc8315 identical to mpc8313 here, just check compatible.
>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
>  arch/powerpc/platforms/83xx/Kconfig       |    2 +-
>  arch/powerpc/platforms/83xx/mpc831x_rdb.c |    3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>

applied.

- k
