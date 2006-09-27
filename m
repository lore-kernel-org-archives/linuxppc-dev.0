Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao08.cox.net (fed1rmmtao08.cox.net [68.230.241.31])
	by ozlabs.org (Postfix) with ESMTP id 26FD367BC1
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 01:59:41 +1000 (EST)
Date: Wed, 27 Sep 2006 08:59:40 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 1/2] Add powerpc get/set_rtc_time interface to new generic
	rtc class
Message-ID: <20060927155940.GC2385@smtp.west.cox.net>
References: <20060926174637.1f70938d.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060926174637.1f70938d.kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 26, 2006 at 05:46:37PM -0500, Kim Phillips wrote:
[snip]
> --- a/include/asm-powerpc/time.h
> +++ b/include/asm-powerpc/time.h
> @@ -39,6 +39,10 @@ extern void generic_calibrate_decr(void)
>  extern void wakeup_decrementer(void);
>  extern void snapshot_timebase(void);
>  
> +#ifdef CONFIG_RTC_CLASS
> +extern int __init rtc_class_hookup(void);
> +#endif

Conditional code doesn't usually get externs ifdef'd, unless I'm
mistaken.

-- 
Tom Rini
