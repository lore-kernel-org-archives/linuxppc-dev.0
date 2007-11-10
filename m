Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 09153DDE08
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Nov 2007 04:11:32 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Sat, 10 Nov 2007 18:11:30 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <1194594629.6561.34.camel@pasglop>
Message-ID: <20071110171130.254580@gmx.net>
MIME-Version: 1.0
References: <20071108214723.135260@gmx.net>	 <1194564017.6561.21.camel@pasglop>
	<20071109074155.266120@gmx.net> <1194594629.6561.34.camel@pasglop>
Subject: Re: Kernel locks up after calling kernel_execve()
To: benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Fri, 09 Nov 2007 18:50:29 +1100
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: linuxppc-dev@ozlabs.org
> Betreff: Re: Kernel locks up after calling kernel_execve()

> 
> > I tried to use /bin/sh as init program and was able to enter a command,
> > but then the machine locked up, too.
> > Could that be a problem with a CPU sleeping/idle code?
> 
> That's possibly an issue, try disabling power save if any for that CPU
> type. If it worked and broke, you may have to bisect tho.
I disabled the powersaving code by adding powersave=off to the kernel's
command line, but it didn't help. It seems to lockup whenever it tries to
access a filesystem.
Is there a way to debug it without a hardware debugger or can you
recommend a cheap hardware debugger?

Gerhard
-- 
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! 
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
