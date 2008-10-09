Return-Path: <timur.tabi@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id 95395DE69D
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 04:23:08 +1100 (EST)
Received: by gxk14 with SMTP id 14so357675gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 09 Oct 2008 10:23:07 -0700 (PDT)
Message-ID: <ed82fe3e0810091023j5f746a9cs7f8564c1e6ea8dcb@mail.gmail.com>
Date: Thu, 9 Oct 2008 12:23:06 -0500
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: [PATCH] powerpc: remove default=y from PMAC and CHRP Kconfigs
In-Reply-To: <48EE3636.7020305@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1223495845-14149-1-git-send-email-timur@freescale.com>
	<1223496186.8157.82.camel@pasglop>
	<ed82fe3e0810081314g34b902f7j76f5049faf91f905@mail.gmail.com>
	<1223498380.8157.86.camel@pasglop> <48ED1B9E.3020907@freescale.com>
	<48EE2A49.10405@genesi-usa.com>
	<ed82fe3e0810090920t25442258gcd5cedabf686fe2d@mail.gmail.com>
	<48EE3636.7020305@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 9, 2008 at 11:49 AM, Matt Sealey <matt@genesi-usa.com> wrote:
> Because they are by far the historically most common configuration, and
> still in production as the defacto standard PowerPC system configuration.

Not really.  PMAC systems are not being built any more.  So that leaves CHRP.

> IBM blades etc. with SLOF will boot up as a CHRP-ish system, as well as the
> Efika and Pegasos and anything else Genesi produces. Since Linux
> distributions generally do not support tiny embedded boards,

So what?  Distributions don't need our help to turn on the options
that are important to them.  This is a ridiculous argument.

> you can imagine why it's
> disabled by default, but there's no reason it can't be ENABLED by default
> and turned off by a distribution, the same way it can't be enabled by
> default and turned off by YOU (compare and contrast having to manually
> select which board you want to build for every time).

This problem is solved with defconfigs.  Kconfig options are supposed
to make sense.  Not all PowerPC systems are CHRP, therefore CHRP
should not be enabled by default.

> But, turning them all on would not matter. You would build a kernel for
> every one and a device tree for every one increasing your build time a
> bit for a default kernel,

Not really true.  Having the default be disabled for specific
platforms can make a big difference in compile time.

> but you would be guaranteed to get a kernel
> binary somewhere in the tree that would work on all of them :)

Again, not relevant.  One giant kernel that works on a Freescale
embedded system *and* an IBM mainframe is useless.  No one would
actually ever do that.

> Genesi, Manager, Developer Relations

Developer Relations, eh?

-- 
Timur Tabi
Linux kernel developer at Freescale
