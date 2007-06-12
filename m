Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 60BD1DDE26
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Jun 2007 03:39:48 +1000 (EST)
Date: Tue, 12 Jun 2007 19:39:46 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Domen Puncer <domen.puncer@telargo.com>
Subject: Re: [PATCH] mpc5200: rtc driver
In-Reply-To: <20070612093821.GH23294@moe.telargo.com>
Message-ID: <Pine.LNX.4.60.0706121935240.5241@poirot.grange>
References: <20070612093821.GH23294@moe.telargo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 12 Jun 2007, Domen Puncer wrote:

> Index: work-powerpc.git/include/asm-powerpc/mpc5200_rtc.h
> ===================================================================
> --- /dev/null
> +++ work-powerpc.git/include/asm-powerpc/mpc5200_rtc.h
> @@ -0,0 +1,49 @@
> +#ifndef _MPC5200_RTC_H_
> +#define _MPC5200_RTC_H_
> +
> +/* RTC */
> +struct mpc52xx_rtc {

Is it really worth putting a header that's only ever going to be used by 1 
file under drivers/rtc under include/asm-*/? If this struct is really only 
for rtc-mpc52xx, just define it .c?

Thanks
Guennadi
---
Guennadi Liakhovetski
