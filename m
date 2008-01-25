Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C1AE6DDEF2
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 11:45:56 +1100 (EST)
Date: Fri, 25 Jan 2008 15:21:37 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 1/9] powerpc: fold the mpc8313 platform into the mpc831x
	platform
In-Reply-To: <20080124204551.10cea5fd.kim.phillips@freescale.com>
Message-ID: <Pine.LNX.4.64.0801251521240.20972@blarg.am.freescale.net>
References: <20080124204551.10cea5fd.kim.phillips@freescale.com>
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

> prepare for adding support for the mpc8315 rdb,
> since they are identical wrt platform code.
>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
> Kumar, this set of patches is base support for two new boards - the
> mpc8315e rdb and the mpc837xe rdb.  Please consider for 2.6.25.  Thanks.
>
>  arch/powerpc/configs/mpc8313_rdb_defconfig         |    2 +-
>  arch/powerpc/platforms/83xx/Kconfig                |    6 ++--
>  arch/powerpc/platforms/83xx/Makefile               |    2 +-
>  .../83xx/{mpc8313_rdb.c => mpc831x_rdb.c}          |   35 +++++++------------
>  4 files changed, 18 insertions(+), 27 deletions(-)
>  rename arch/powerpc/platforms/83xx/{mpc8313_rdb.c => mpc831x_rdb.c} (70%)
>

applied.

- k
