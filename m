Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DE3EADDDB5
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 17:05:55 +1100 (EST)
Subject: Re: Badness at kernel/time/timekeeping.c:98 in pmud
	(timekeeping_suspended)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <alpine.LFD.2.00.0902091302310.415@localhost.localdomain>
References: <87prihcepl.fsf@burly.wgtn.ondioline.org>
	<87k58nda87.fsf@burly.wgtn.ondioline.org>
	<874oz5pmvd.fsf@burly.wgtn.ondioline.org>
	<200902081439.31548.rjw@sisk.pl>
	<alpine.LFD.2.00.0902091302310.415@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 12 Feb 2009 17:05:24 +1100
Message-Id: <1234418724.29851.53.camel@pasglop>
Mime-Version: 1.0
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@elte.hu>, Paul Collins <paul@burly.ondioline.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> The commit fixed the problem with sched_clock, but it does not fix
> problems where other parts of the kernel call timekeeping functions
> _AFTER_ timekeeping has been suspended.

Maybe we should use the PMU sysdev which is used for suspending
backlight stuff etc... to also suspend emitting of the input events.

Cheers,
Ben.
