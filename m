Return-Path: <joern@wohnheim.fh-wedel.de>
Received: from moskovskaya.fh-wedel.de (mail.fh-wedel.de [213.39.232.198])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 500BC67A7B
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Mar 2005 03:06:10 +1100 (EST)
Date: Fri, 4 Mar 2005 17:06:07 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Matt Porter <mporter@kernel.crashing.org>
Message-ID: <20050304160607.GA19598@wohnheim.fh-wedel.de>
References: <46110262C7A0BF418DE9C9A5BD73F92807F2F94C@cceexc23.americas.cpqcorp.net>
	<200503011737.22205.g.jaeger@sysgo.com>
	<20050302215308.GA6511@wohnheim.fh-wedel.de>
	<200503030923.22677.g.jaeger@sysgo.com>
	<20050303230541.GA7274@wohnheim.fh-wedel.de>
	<20050304083921.A2508@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20050304083921.A2508@cox.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Building a Kernel for the AMCC PPC440EP Bamboo Board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 4 March 2005 08:39:22 -0700, Matt Porter wrote:
> 
> Impossible. You need a 440EP/Bamboo specific port. Memory map is
> completely different on 440EP.  For discussion sake, note that
> 440GP/GX are very similar parts with respect to memory map and
> peripherals, then 440SP and 440EP each have very different layouts.

Right.

> FWIW, there's somebody well into a 2.6 440EP port, dunno what the
> ETA on submitting the code is.

Would be nice to get either somebody's name or the preliminary code.
I don't care about crashes too much (can't be worse than not working
at all) and am willing to help.  If neither is realistic - heck, we
need to get familiar with the cpu anyway, so there is no reason not to
race for submission. ;)

Jörn

-- 
A surrounded army must be given a way out.
-- Sun Tzu
