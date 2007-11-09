Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 21511DDE20
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 18:41:57 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Fri, 09 Nov 2007 08:41:55 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <1194564017.6561.21.camel@pasglop>
Message-ID: <20071109074155.266120@gmx.net>
MIME-Version: 1.0
References: <20071108214723.135260@gmx.net> <1194564017.6561.21.camel@pasglop>
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
> Datum: Fri, 09 Nov 2007 10:20:17 +1100
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: linuxppc-dev@ozlabs.org
> Betreff: Re: Kernel locks up after calling kernel_execve()

> 
> On Thu, 2007-11-08 at 22:47 +0100, Gerhard Pircher wrote:
> > Hi,
> > 
> > I tested my patches for the AmigaOne platform with the lastest
> > 2.6.24-rc2 kernel snapshot. The kernel runs through all initcalls, but
> > locks up completely after calling INIT (/sbin/init) by kernel_execve().
> > Thus I couldn't capture any kernel oops or panic output. Also the magic 
> > sysrq key doesn't work. Enabling debug code for soft lockups and
> > spinlock debugging didn't reveal any information.
> > I'm not sure, but I think it is the same problem I had with all kernels
> > >= 2.6.17. All of these kernels lock up shortly before or right at
> > calling the init program (resp. as soon as the kernel forks some kernel
> > theads).
> > Any suggestions on how to track down this problem?
> 
> You don't have a HW debugger or anything like that ?
> 
> Ben.
Unfortunately, no. A BDI2000 is too costly for me.

I tried to use /bin/sh as init program and was able to enter a command,
but then the machine locked up, too.
Could that be a problem with a CPU sleeping/idle code?

Gerhard

-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört?
Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger
