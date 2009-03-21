Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CD70DDDE00
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Mar 2009 03:46:19 +1100 (EST)
Date: Sat, 21 Mar 2009 17:46:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] tracing: Fix TRACING_SUPPORT dependency
Message-ID: <20090321164604.GL11183@elte.hu>
References: <20090320150914.GA22769@oksana.dev.rtsoft.ru>
	<20090320190428.GD6224@elte.hu>
	<20090320193904.GA13707@oksana.dev.rtsoft.ru>
	<20090320195743.GA25147@elte.hu>
	<20090320202247.GA30654@oksana.dev.rtsoft.ru>
	<20090321161814.GC11183@elte.hu>
	<alpine.DEB.2.00.0903211230580.13615@gandalf.stny.rr.com>
	<20090321163328.GH11183@elte.hu>
	<alpine.DEB.2.00.0903211239170.13615@gandalf.stny.rr.com>
	<alpine.DEB.2.00.0903211242530.13615@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.00.0903211242530.13615@gandalf.stny.rr.com>
Cc: linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> On Sat, 21 Mar 2009, Steven Rostedt wrote:
> > 
> > Since we know that's not an issue with PPC32, perhaps we should add (I 
> > hate to do this)...
> > 
> > 
> > 	depends on TRACE_IRQFLAGS_SUPPORT || PPC32
> > 
> > And document that the "|| PPC32" should go when PowerPC32 gets its act
> > together.  :-/
> 
> Note, the only tracer broken on PPC32 is the IRQSOFF tracer, and 
> that already depends on TRACE_IRQFLAGS_SUPPORT.

Ok, that's fine with me too. Perhaps we could add a TRACING_SUPPORT 
thing that architectures can enable - but it's probably overkill in 
this case.

	Ingo
