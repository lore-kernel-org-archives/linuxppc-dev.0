Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B6E9FDDE23
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 07:07:46 +1100 (EST)
Date: Tue, 22 Jan 2008 14:05:17 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] adder875: Fix flash bus-width and remove duplicate
	__initdata.
In-Reply-To: <20080122183141.GB17036@loki.buserror.net>
Message-ID: <Pine.LNX.4.64.0801221405070.19903@blarg.am.freescale.net>
References: <20080122183141.GB17036@loki.buserror.net>
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

On Tue, 22 Jan 2008, Scott Wood wrote:

> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/boot/dts/adder875-redboot.dts |    2 +-
>  arch/powerpc/boot/dts/adder875-uboot.dts   |    2 +-
>  arch/powerpc/platforms/8xx/adder875.c      |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>

applied.

- k
