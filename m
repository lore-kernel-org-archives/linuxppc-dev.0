Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C035DDDDA1
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Feb 2009 02:11:35 +1100 (EST)
Date: Sun, 8 Feb 2009 16:11:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Badness at kernel/time/timekeeping.c:98 in pmud
	(timekeeping_suspended)
Message-ID: <20090208151122.GB5314@elte.hu>
References: <87prihcepl.fsf@burly.wgtn.ondioline.org>
	<87k58nda87.fsf@burly.wgtn.ondioline.org>
	<874oz5pmvd.fsf@burly.wgtn.ondioline.org>
	<200902081439.31548.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200902081439.31548.rjw@sisk.pl>
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	Paul Collins <paul@burly.ondioline.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> On Sunday 08 February 2009, Paul Collins wrote:
> > Paul Collins <paul@burly.ondioline.org> writes:
> > 
> > > "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> > >
> > >> On Wednesday 21 January 2009, Paul Collins wrote:
> > >>> Got a couple of these on a PowerBook running 2.6.29-rc2 either during
> > >>> suspend or resume -- it's hard to tell.  (The suspend message is
> > >>> timestamped in syslog with the time I resumed, so I guess it was
> > >>> buffered along with the subsequent "Badness" messages.)
> > >>
> > >> Please check if the patch from http://lkml.org/lkml/2009/1/13/144 fixes the
> > >> problem for you.
> > >
> > > It does not fix the problem.
> > 
> > I'm also getting this warning since 2.6.28.1, which incorporated commit
> > 1c5745aa380efb6417b5681104b007c8612fb496 ("sched_clock: prevent
> > scd->clock from moving backwards, take #2") as commit
> > e268dcdd404f4558cdd24c8ecede3e064df8fa33, this being the patch that
> > introduced the WARN_ON(timekeeping_suspended) check.
> 
> Hm, I thought the timekeeping suspend problem was fixed in this commit.  Ingo?

Thomas? :-)

	Ingo
