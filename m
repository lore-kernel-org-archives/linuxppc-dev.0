Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D441167A58
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 08:47:41 +1000 (EST)
Subject: Re: cpu power "management" for non-dfs chips with no pmu (for
	instance, 750cxe and mpc7447 in pegasos)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@jdl.com>
In-Reply-To: <E1Ftmcb-0007rG-QS@jdl.com>
References: <01ca01c696cd$2e453f30$99dfdfdf@bakuhatsu.net>
	<E1Ftmcb-0007rG-QS@jdl.com>
Content-Type: text/plain
Date: Wed, 28 Jun 2006 08:47:24 +1000
Message-Id: <1151448444.2350.102.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > ICTC is such a simple thing to support and you can slow down the CPU
> > pretty comprehensively (from halving to 255x in theory) with an on and
> > off flag. I am surprised nobody implemented a cpufreq governer even if
> > it is totally useless and gives no perceivable benefits..
> 
> See?  You _are_ contributing already.  I encourage
> you to hit the linux-pm@lists.osdl.org list for a spell!

His question is very powerpc specific... I don't see the point of
bringing ICTC related discussions to linux-pm...

Now, we _did_ some experiemnts in the past and didn't see that much
improvements. That might have changed though, since those 744x/745x CPUs
cannot DOZE and we cannot use their NAP mode neither when idle on
Pegasdos, in which case ICTC might have some use there...

It's easy to tweak it, just test and tell us. I'm not sure if cpufreq is
the right interface though as the cpu frequency isn't actually changing.

Ben.
