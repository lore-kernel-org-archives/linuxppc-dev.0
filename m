Return-Path: <pavel@ucw.cz>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
	[195.113.26.193])
	by bilbo.ozlabs.org (Postfix) with ESMTP id EE348B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 Aug 2009 21:58:17 +1000 (EST)
Date: Wed, 12 Aug 2009 13:58:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH 0/3] cpu: idle state framework for offline CPUs.
Message-ID: <20090812115806.GK24339@elf.ucw.cz>
References: <20090805142311.553.78286.stgit@sofia.in.ibm.com>
	<20090806015855.GA20596@sli10-desk.sh.intel.com>
	<20090809120818.GA1338@ucw.cz> <200908091522.02898.rjw@sisk.pl>
	<20090810081941.GA18649@elf.ucw.cz>
	<1249950137.11545.38184.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1249950137.11545.38184.camel@localhost.localdomain>
Cc: "Brown, Len" <len.brown@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Gautham R Shenoy <ego@in.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, "Li,
	Shaohua" <shaohua.li@intel.com>, Ingo Molnar <mingo@elte.hu>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"Darrick J. Wong" <djwong@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi!

> May be having (to pick a number) 3 possible offline states for all
> platforms with one for halt equivalent and one for deepest possible that
> CPU can handle and one for deepest possible that platform likes for
> C-states may make sense. Will keeps things simpler in terms of usage
> expectations and possibly reduce the misuse oppurtubity?

Maybe just going to the deepest offline state automatically is the
easiest option?

cpu hotplug/unplug should be rare-enough operation that the latencies
do not really matter, right?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
