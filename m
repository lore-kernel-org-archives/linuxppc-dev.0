Return-Path: <mikenuss@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.187])
	by ozlabs.org (Postfix) with ESMTP id CF4C2DDEF3
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 04:18:24 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so1610205rvf
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 11:18:23 -0700 (PDT)
Message-ID: <a340dd0e0709251118n108799adxb60af2afa6ac9a96@mail.gmail.com>
Date: Tue, 25 Sep 2007 14:18:22 -0400
From: "Mike Nuss" <mikenuss@gmail.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: Book-E watchdog driver questions
In-Reply-To: <2A9ADFCB-2725-4156-BE66-4E55A4987E2D@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <46F93E54.5050203@gmail.com>
	<2A9ADFCB-2725-4156-BE66-4E55A4987E2D@kernel.crashing.org>
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > Is there a reason that booke_wdt.c does not specify a MODULE_LICENSE?
> >> From the copyright notice at the top it appears to be GPL. As
> >> written,
> > it taints the kernel.
>
> Odd, no reason.  I'll submit a patch for that.
>
> > Also, if I test out the driver by killing my process that's doing the
> > pinging, I get a kernel panic:
>
> Its been a while since i've tried this.  I'll try it out and see what
> happens.

I also found that GETBOOTSTATUS returns 0 after the reboot. Looking at
the source code I found the comment "XXX: something is clearing TSR" -
I take that to mean that the register is being cleared by something
before the module tries to read it? In my case U-Boot may be clearing
that - I can take a look.

Mike
