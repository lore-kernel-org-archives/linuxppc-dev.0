Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1BFDADDE2B
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 11:45:54 +1100 (EST)
Date: Fri, 25 Jan 2008 15:20:38 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 3/5] [POWERPC][SPI] use brg-frequency for SPI in QE
In-Reply-To: <20080124154003.GC23246@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0801251520260.20972@blarg.am.freescale.net>
References: <20080124151850.GA15190@localhost.localdomain>
	<20080124154003.GC23246@localhost.localdomain>
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

On Thu, 24 Jan 2008, Anton Vorontsov wrote:

> In case of QE we can use brg-frequency (which is qeclk/2).
> Thus no need to divide sysclk in the spi_mpc83xx.
>
> This patch also adds code to use get_brgfreq() on QE chips.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> Acked-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
>  arch/powerpc/sysdev/fsl_soc.c |   44 ++++++++++++++++++++++++++++------------
>  drivers/spi/spi_mpc83xx.c     |    6 +----
>  2 files changed, 32 insertions(+), 18 deletions(-)
>

applied

- k
