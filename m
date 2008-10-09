Return-Path: <sven@powerlinux.fr>
Received: from archon.plz.fr (archon.plz.fr [194.50.78.210])
	by ozlabs.org (Postfix) with ESMTP id 905E4DE34D
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 07:18:36 +1100 (EST)
Date: Thu, 9 Oct 2008 22:18:33 +0200
From: Sven Luther <sven@genesi-usa.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: remove default=y from PMAC and CHRP Kconfigs
Message-ID: <20081009201833.GA14746@powerlinux.fr>
References: <1223495845-14149-1-git-send-email-timur@freescale.com>
	<1223496186.8157.82.camel@pasglop>
	<ed82fe3e0810081314g34b902f7j76f5049faf91f905@mail.gmail.com>
	<1223498380.8157.86.camel@pasglop> <48ED1B9E.3020907@freescale.com>
	<48EE2A49.10405@genesi-usa.com>
	<ed82fe3e0810090920t25442258gcd5cedabf686fe2d@mail.gmail.com>
	<48EE3636.7020305@genesi-usa.com>
	<ed82fe3e0810091023j5f746a9cs7f8564c1e6ea8dcb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ed82fe3e0810091023j5f746a9cs7f8564c1e6ea8dcb@mail.gmail.com>
Cc: sven@genesi-usa.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 09, 2008 at 12:23:06PM -0500, Timur Tabi wrote:
> On Thu, Oct 9, 2008 at 11:49 AM, Matt Sealey <matt@genesi-usa.com> wrote:
> > Because they are by far the historically most common configuration, and
> > still in production as the defacto standard PowerPC system configuration.
> 
> Not really.  PMAC systems are not being built any more.  So that leaves CHRP.
> 
> > IBM blades etc. with SLOF will boot up as a CHRP-ish system, as well as the
> > Efika and Pegasos and anything else Genesi produces. Since Linux
> > distributions generally do not support tiny embedded boards,
> 
> So what?  Distributions don't need our help to turn on the options
> that are important to them.  This is a ridiculous argument.
> 
> > you can imagine why it's
> > disabled by default, but there's no reason it can't be ENABLED by default
> > and turned off by a distribution, the same way it can't be enabled by
> > default and turned off by YOU (compare and contrast having to manually
> > select which board you want to build for every time).
> 
> This problem is solved with defconfigs.  Kconfig options are supposed

...

> Not really true.  Having the default be disabled for specific
> platforms can make a big difference in compile time.

Notice that the defconfigs answer also applies here :)

Friendly,

Sven Luther
