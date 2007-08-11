Return-Path: <sam@ravnborg.org>
Received: from pasmtpA.tele.dk (pasmtpa.tele.dk [80.160.77.114])
	by ozlabs.org (Postfix) with ESMTP id AE764DDF50
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Aug 2007 21:35:00 +1000 (EST)
Date: Sat, 11 Aug 2007 13:35:45 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: 2.6.23-rc2-mm2 build error on MIPS and ARM
Message-ID: <20070811113545.GB11651@uranus.ravnborg.org>
References: <20070811025802.GA15885@Krystal>
	<1186825800.32314.2.camel@localhost>
	<20070811095658.GA11651@uranus.ravnborg.org>
	<1186829697.3930.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1186829697.3930.4.camel@localhost>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Aug 11, 2007 at 12:54:57PM +0200, Martin Schwidefsky wrote:
> On Sat, 2007-08-11 at 11:56 +0200, Sam Ravnborg wrote:
> > > That attached patch should fix it for arm and mips. I'll try a few more
> > > architectures until I'm fed up with compiling cross-compilers..
> > http://userweb.kernel.org/~akpm/cross-compilers/
> 
> Thanks for the hint but I prefer to compile them on my own (naming
> scheme, installation target, 4.1.2, ..). The first one is the hardest,
> for the following ones it is just a matter how fast you machine is.
> I'll do one cross-compiler every 15 minutes right now (without glibc).
Should dive into this myself one day.
But for now crosstool has saved my day.

	Sam
