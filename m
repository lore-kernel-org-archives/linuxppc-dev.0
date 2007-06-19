Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BCB1FDDF15
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 16:44:01 +1000 (EST)
In-Reply-To: <20070619063557.GK9768@bakeyournoodle.com>
References: <20070619063557.GK9768@bakeyournoodle.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <17efca495a2d08aa8ad577fca22659c0@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH/RFC] Modify sched_clock() to make CONFIG_PRINTK_TIME more
	sane.
Date: Tue, 19 Jun 2007 08:43:51 +0200
To: tony@bakeyournoodle.com (Tony Breeds)
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> When booting a current kernel with CONFIG_PRINTK_TIME enabled you'll
> see messages like:
>
> [    0.000000] time_init: decrementer frequency = 188.044000 MHz
> [    0.000000] time_init: processor frequency   = 1504.352000 MHz
> [3712914.436297] Console: colour dummy device 80x25
>
> This patch modifies sched_clock() to report the offset since the 
> machine booted
> so the same printk's now look like:
>
> [    0.000000] time_init: decrementer frequency = 188.044000 MHz
> [    0.000000] time_init: processor frequency   = 1504.352000 MHz
> [    0.000135] Console: colour dummy device 80x25
>
> Effectivly including the uptime in printk()s.

This was long overdue, thank you Tony!


Segher
