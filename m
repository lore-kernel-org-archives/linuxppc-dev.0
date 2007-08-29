Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2C6D9DDE0F
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 08:33:48 +1000 (EST)
Date: Wed, 29 Aug 2007 17:33:47 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 4/4] fsl_soc.c cleanup
In-Reply-To: <20070820163812.GC29912@ld0162-tx32.am.freescale.net>
Message-ID: <Pine.LNX.4.64.0708291733290.26956@blarg.am.freescale.net>
References: <20070820163812.GC29912@ld0162-tx32.am.freescale.net>
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

On Mon, 20 Aug 2007, Scott Wood wrote:

> 1. Fix get_immrbase() to use ranges, rather than reg.
>
> It is not always the case that the SoC's first reg property points
> to the beginning of the entire SoC block.
>
> 2. Update the way get_brgfreq() finds things in the device tree.
>
> It now uses names that are less namespace polluting.  The old names
> are supported until all boards are converted.
>
> 3. "size" is changed from unsigned int to int, to match what
> of_get_property() expects.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/sysdev/fsl_soc.c |   38 +++++++++++++++++++++++++++-----------
>  1 files changed, 27 insertions(+), 11 deletions(-)

applied.

- k
