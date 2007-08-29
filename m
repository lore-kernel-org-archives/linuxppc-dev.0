Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2E9B1DDE1C
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 08:35:08 +1000 (EST)
Date: Wed, 29 Aug 2007 17:35:09 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] powerpc: linkstation updates
In-Reply-To: <Pine.LNX.4.60.0708252358440.3809@poirot.grange>
Message-ID: <Pine.LNX.4.64.0708291733540.26956@blarg.am.freescale.net>
References: <Pine.LNX.4.60.0708252358440.3809@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 26 Aug 2007, Guennadi Liakhovetski wrote:

> 1. Fix RTC type - it is a rs5c372a, not rs5c372b
> 2. Configure both UART interrupts edge-triggered
> 3. Add a license header to ls_uart.c
> 4. Check for running on linkstation in a late_initcall() function. Needed
>    for multiplatform builds, even though linkstation doesn't support them
>    yet
> 5. Remove unneeded #include from linkstation.c
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>
> ---
>
> Nothing critical - just queue this for .24, please.
>
> Thanks
> Guennadi
>
>  boot/dts/kuroboxHD.dts              |    4 ++--
>  boot/dts/kuroboxHG.dts              |    4 ++--
>  platforms/embedded6xx/linkstation.c |    1 -
>  platforms/embedded6xx/ls_uart.c     |   14 ++++++++++++++
>  4 files changed, 18 insertions(+), 5 deletions(-)
>

applied.

- k
