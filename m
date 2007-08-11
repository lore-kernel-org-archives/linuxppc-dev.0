Return-Path: <schwidefsky@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 918B6DDF09
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Aug 2007 20:51:35 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id l7BApTQb243418
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Aug 2007 10:51:29 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l7BApTDa2134212
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Aug 2007 12:51:29 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l7BApQ7U025076
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Aug 2007 12:51:26 +0200
Subject: Re: 2.6.23-rc2-mm2 build error on MIPS and ARM
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20070811095658.GA11651@uranus.ravnborg.org>
References: <20070811025802.GA15885@Krystal>
	<1186825800.32314.2.camel@localhost>
	<20070811095658.GA11651@uranus.ravnborg.org>
Content-Type: text/plain
Date: Sat, 11 Aug 2007 12:54:57 +0200
Message-Id: <1186829697.3930.4.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	linux-kernel@vger.kernel.org
Reply-To: schwidefsky@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-08-11 at 11:56 +0200, Sam Ravnborg wrote:
> > That attached patch should fix it for arm and mips. I'll try a few more
> > architectures until I'm fed up with compiling cross-compilers..
> http://userweb.kernel.org/~akpm/cross-compilers/

Thanks for the hint but I prefer to compile them on my own (naming
scheme, installation target, 4.1.2, ..). The first one is the hardest,
for the following ones it is just a matter how fast you machine is.
I'll do one cross-compiler every 15 minutes right now (without glibc).

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
