Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 14202DDDFA
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 03:24:23 +1100 (EST)
Date: Mon, 21 Jan 2008 10:21:22 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/3] mpc8313erdb: Add NAND to device tree, and call
	of_platform_bus_probe().
In-Reply-To: <20080117223750.GA20697@loki.buserror.net>
Message-ID: <Pine.LNX.4.64.0801211021120.14453@blarg.am.freescale.net>
References: <20080117223750.GA20697@loki.buserror.net>
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

On Thu, 17 Jan 2008, Scott Wood wrote:

> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> Please apply this series for 2.6.25.
>
>  arch/powerpc/boot/dts/mpc8313erdb.dts     |   39 +++++++++++++++++++++++++++++
>  arch/powerpc/platforms/83xx/mpc8313_rdb.c |   13 +++++++++
>  2 files changed, 52 insertions(+), 0 deletions(-)
>

applied.

- k
