Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 5171DDE19E
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Apr 2009 04:35:12 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] Quieten arch/powerpc in a allmodconfig build.
References: <2c4bcf8d1d7083ff53ce5b556765e96676a007fb.1239165378.git.tony@bakeyournoodle.com>
	<1239167335.10104.26.camel@localhost>
	<20090408055126.GG16602@bilbo.ozlabs.org>
	<7ED93BB3-FE0E-4102-89FB-78950A533717@kernel.crashing.org>
	<20090409224553.GO16602@bilbo.ozlabs.org>
	<20090410091149.5068d8e1.sfr@canb.auug.org.au>
	<1AAD5906-66FA-4850-8C62-8C030816E44E@kernel.crashing.org>
	<49DF89F7.2070403@freescale.com>
Date: Fri, 10 Apr 2009 20:35:03 +0200
In-Reply-To: <49DF89F7.2070403@freescale.com> (Scott Wood's message of "Fri,
	10 Apr 2009 13:03:35 -0500")
Message-ID: <m2bpr4l5m0.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> writes:

> The problem is that GCC does not give an error (only a warning) even for
> things like this where it should be trivial to detect that the usage *is*
> uninitialized, not just might be:
>
> int foo(void)
> {
>    int a;
>
>    return a;
> }

The compiler must not reject this code, because the undefined behavior
only occurs if executed.  There is no constraint violated.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
