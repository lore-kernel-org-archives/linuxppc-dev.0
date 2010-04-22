Return-Path: <R1AAHA@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B0317B7BEE
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Apr 2010 10:32:55 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3M0WqVl018714
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Apr 2010 17:32:52 -0700 (MST)
Received: from az33exm22.fsl.freescale.net (az33exm22.am.freescale.net
	[10.64.32.10])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o3M0g90w015506
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Apr 2010 19:42:09 -0500 (CDT)
Date: Wed, 21 Apr 2010 19:44:19 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Csdncannon <csdncannon@gmail.com>
Subject: Re: Continual reading from the PowerPc time base register is not
	stable
Message-Id: <20100421194419.3edf2c80.kim.phillips@freescale.com>
In-Reply-To: <o2y43c137a81004092014z1511cecdxb7154825dc07b49f@mail.gmail.com>
References: <43c137a81003241941p84cba56y3e02e40cb22623e2@mail.gmail.com>
	<o2y43c137a81004092014z1511cecdxb7154825dc07b49f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, zhouminggang@hotmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 10 Apr 2010 11:14:09 +0800
Csdncannon <csdncannon@gmail.com> wrote:

> Sorry, I attached the wrong log, this attachment is the right one.
> 
> 2010/3/25 Csdncannon <csdncannon@gmail.com>
> 
> >          In my program, the value of the 64-bit time base register is read
> > out, and you will find the later value is even smaller than the earlier
> > value from the log “log_timebase”. While the kernel depends on the accuracy
> > of the timebase for the compensation of the lost PIT interrupt, the negative
> > value between two continual timebase reading will bring to the jump of the
> > jiffies. And this timebase problem will bring to the instability of the
> > gettimeofday system call.
> >
> >          Do you have any idea about this problem, thanks for your any
> > advice. Attached is the code and log.

Hi, has this been resolved yet?

I took an 8377 rdb board, and let it run timebase.c (with the isync &
long long casts) all weekend, and have failed to reproduce the issue.
That was on linux 2.6.33, and I've got another machine running the same
thing under 2.6.28 for the last couple of hours, still unable to
reproduce the issue.

Can you please answer the "custom board or FSL reference board"
question, try duplicating with a newer kernel version, discuss other
time sources that may be running on your system (RTC_DRV, ntp service),
post a .config, ...

Kim
