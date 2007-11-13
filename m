Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 5CACDDDDE9
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 08:23:23 +1100 (EST)
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 13 Nov 2007 22:23:20 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <1194753340.21340.24.camel@pasglop>
Message-ID: <20071113212320.85840@gmx.net>
MIME-Version: 1.0
References: <20071108214723.135260@gmx.net>	 <1194564017.6561.21.camel@pasglop>
	<20071109074155.266120@gmx.net>	 <1194594629.6561.34.camel@pasglop>
	<20071110171130.254580@gmx.net> <1194753340.21340.24.camel@pasglop>
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
> Datum: Sun, 11 Nov 2007 14:55:40 +1100
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: linuxppc-dev@ozlabs.org
> Betreff: Re: Kernel locks up after calling kernel_execve()

> 
> On Sat, 2007-11-10 at 18:11 +0100, Gerhard Pircher wrote:
> > -------- Original-Nachricht --------
> > > Datum: Fri, 09 Nov 2007 18:50:29 +1100
> > > Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > An: Gerhard Pircher <gerhard_pircher@gmx.net>
> > > CC: linuxppc-dev@ozlabs.org
> > > Betreff: Re: Kernel locks up after calling kernel_execve()
> >
> > Is there a way to debug it without a hardware debugger or can you
> > recommend a cheap hardware debugger?
> 
> There are ways, sure, which probably involve adding prink's all over the
> place to figure it out... could be some DMA issue for example, could be
> pretty much anything. Have you tried booting an initrd with no disk
> access ?
I tried to boot with a ramdisk, but that didn't help much. I still locks up
while loading an init program or after entering some commands in
sh shell. Looks like the problem is hidden deep in the kernel.

Thanks!

Gerhard

-- 
GMX FreeMail: 1 GB Postfach, 5 E-Mail-Adressen, 10 Free SMS.
Alle Infos und kostenlose Anmeldung: http://www.gmx.net/de/go/freemail
