Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2C483476DD
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 06:20:58 +1100 (EST)
Date: Thu, 20 Nov 2008 20:20:09 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/5] powerpc: dynamic ftrace port
Message-ID: <20081120192009.GE3955@elte.hu>
References: <20081120190948.057007623@goodmis.org>
	<alpine.DEB.1.10.0811201412230.3378@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.1.10.0811201412230.3378@gandalf.stny.rr.com>
Cc: Matt Fleming <mjf@gentoo.org>, linux-kernel@vger.kernel.org,
	Milton Miller <miltonm@bga.com>, linuxppc-dev@ozlabs.org,
	Paul Mundt <lethal@linux-sh.org>, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 20 Nov 2008, Steven Rostedt wrote:
> > 
> >  1) I removed the changes to recordmcount.pl.  This is not a PowerPC
> >     change, although PowerPC needs it for dynamic ftrace. But
> >     the changes here can go via linux-tip.
> 
> Ingo,
> 
> I found that the recordmcount.pl change conflicts with a commit in 
> linux-next, which is not in tip nor mainline. The commit is:
> 
>    11ebca4a3f8337de2f4d1300bd307851d1191d53
>    sh: dynamic ftrace support.
> 
> Seems that this change came in through the sh repo. I have already 
> resolved the conflicts with my updates for PowerPC with this commit. 
> I can put this in a separate branch against linux-next if you like.
> 
> I would like to get the changes to recordmcount.pl for PowerPC in 
> linux-next soon, so I can also add a small clean up of this code. 
> Jim Radfort has some updates as well for his port to arm.

Could you please extract the sh bits from 11ebca4a so that we can 
apply it to tip/tracing/* standalone? It makes sense to carry it 
without having the other bits of the SH changes.

It will collide in linux-next but it will be a same-content collision 
with an easy enough (perhaps even automatic) resolution.

	Ingo
