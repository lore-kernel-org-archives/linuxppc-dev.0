Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id 291F367A6D
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Mar 2005 02:39:44 +1100 (EST)
Date: Fri, 4 Mar 2005 08:39:22 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Message-ID: <20050304083921.A2508@cox.net>
References: <46110262C7A0BF418DE9C9A5BD73F92807F2F94C@cceexc23.americas.cpqcorp.net>
	<200503011737.22205.g.jaeger@sysgo.com>
	<20050302215308.GA6511@wohnheim.fh-wedel.de>
	<200503030923.22677.g.jaeger@sysgo.com>
	<20050303230541.GA7274@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050303230541.GA7274@wohnheim.fh-wedel.de>;
	from joern@wohnheim.fh-wedel.de on Fri, Mar 04, 2005 at
	12:05:41AM +0100
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

On Fri, Mar 04, 2005 at 12:05:41AM +0100, J?rn Engel wrote:
> On Thu, 3 March 2005 09:23:22 +0100, Gerhard Jaeger wrote:
> > > 
> > Could not confirm that so far! Ebony and Ocotea are working out of the
> > box, using these defconfig files! (pristine kernel 2.6.11)
> 
> With PIBS and on a bamboo?  If I was just too stupid and made some
> silly mistake, that would be great news.

Impossible. You need a 440EP/Bamboo specific port. Memory map is
completely different on 440EP.  For discussion sake, note that
440GP/GX are very similar parts with respect to memory map and
peripherals, then 440SP and 440EP each have very different layouts.

FWIW, there's somebody well into a 2.6 440EP port, dunno what the
ETA on submitting the code is.

-Matt
