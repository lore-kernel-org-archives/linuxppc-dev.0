Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 318F5DDE26
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 16:44:09 +1100 (EST)
Subject: Re: [PATCH] tracing: Fix TRACING_SUPPORT dependency
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20090320202247.GA30654@oksana.dev.rtsoft.ru>
References: <20090320150914.GA22769@oksana.dev.rtsoft.ru>
	<20090320190428.GD6224@elte.hu>
	<20090320193904.GA13707@oksana.dev.rtsoft.ru>
	<20090320195743.GA25147@elte.hu>
	<20090320202247.GA30654@oksana.dev.rtsoft.ru>
Content-Type: text/plain
Date: Tue, 24 Mar 2009 16:43:50 +1100
Message-Id: <1237873430.25062.715.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <srostedt@redhat.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Weird, there's no lockdep support?
> 
> *ashamed*: apparently no such support currently exist for PPC32. ;-)

Actually there is a patch that's been floating around (from Dale
Farnsworth) for adding irqtrace/lockdep to ppc32 but it seems to be
buggy :-) IE, it causes crashes and I haven't had a chance
to try to find out yet. I'll probably give it another go one of these
days, but if you want to play with it, I'll send it to you directly.

Cheers,
Ben.
