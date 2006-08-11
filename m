Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17628.4499.609213.401518@cargo.ozlabs.ibm.com>
Date: Fri, 11 Aug 2006 15:11:47 +1000
From: Paul Mackerras <paulus@samba.org>
To: Tsutomu OWA <tsutomu.owa@toshiba.co.jp>
Subject: Re: [RFC PATCH 1/4] powerpc 2.6.16-rt17: to build on powerpc w/ RT
In-Reply-To: <yyiodushvxs.wl@forest.swc.toshiba.co.jp>
References: <yyiodushvxs.wl@forest.swc.toshiba.co.jp>
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu, tglx@linutronix.de,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tsutomu OWA writes:

> diff -rup -x CVS 2.6.16-rt17/arch/powerpc/kernel/time.c rt-powerpc/arch/powerpc/kernel/time.c
> --- 2.6.16-rt17/arch/powerpc/kernel/time.c	2006-04-26 18:24:28.000000000 +0900
> +++ rt-powerpc/arch/powerpc/kernel/time.c	2006-07-12 13:45:31.000000000 +0900
> @@ -200,6 +200,7 @@ void udelay(unsigned long usecs)
>  }
>  EXPORT_SYMBOL(udelay);
>  
> +#ifndef CONFIG_GENERIC_TIME

I would be very surprised if this is all that is required for
CONFIG_GENERIC_TIME to work correctly on powerpc.  Have you verified
that the CONFIG_GENERIC_TIME stuff works correctly on powerpc and
provides all the features provided by the current implementation?

Paul.
