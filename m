Return-Path: <jdl@jdl.com>
Received: from jdl.com (www.jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8381A67B19
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jun 2006 00:27:02 +1000 (EST)
To: matt@genesi-usa.com
Subject: Re: cpu power "management" for non-dfs chips with no pmu (for
	instance, 750cxe and mpc7447 in pegasos)
In-Reply-To: Your message of "Fri, 23 Jun 2006 08:58:56 CDT."
	<01ca01c696cd$2e453f30$99dfdfdf@bakuhatsu.net>
References: <01ca01c696cd$2e453f30$99dfdfdf@bakuhatsu.net> 
Date: Fri, 23 Jun 2006 09:26:57 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Ftmcb-0007rG-QS@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day "Matt Sealey" mumbled:
> 
> I have nothing real to contribute other than I would like to see it :)

Disbelief.  :-)

> Before I asked I checked Google (as is expected of anyone these days)
> and found some discussions on debian-powerpc from 2002 but nobody
> really did anything and nothing really came of it. I know 4 years later
> all we have is powernowd which pokes up cpufreq which only supports
> DFS and certain kinds of Mac PMU. 

Which is why it is all being revitalized now... :-)
There was a mini symposium a couple months ago that started
a few working groups to help kick start this back into viability.

> ICTC is such a simple thing to support and you can slow down the CPU
> pretty comprehensively (from halving to 255x in theory) with an on and
> off flag. I am surprised nobody implemented a cpufreq governer even if
> it is totally useless and gives no perceivable benefits..

See?  You _are_ contributing already.  I encourage
you to hit the linux-pm@lists.osdl.org list for a spell!

You could start here:
	https://lists.osdl.org/mailman/listinfo/linux-pm

Thanks,
jdl
