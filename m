Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 16CB1DDE07
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2009 06:57:59 +1100 (EST)
Date: Fri, 20 Mar 2009 20:57:43 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] tracing: Fix TRACING_SUPPORT dependency
Message-ID: <20090320195743.GA25147@elte.hu>
References: <20090320150914.GA22769@oksana.dev.rtsoft.ru>
	<20090320190428.GD6224@elte.hu>
	<20090320193904.GA13707@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090320193904.GA13707@oksana.dev.rtsoft.ru>
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


* Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> On Fri, Mar 20, 2009 at 08:04:28PM +0100, Ingo Molnar wrote:
> > 
> > * Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> > 
> > > commit 40ada30f9621fbd831ac2437b9a2a399aad34b00 ("tracing: clean 
> > > up menu"), despite the "clean up" in its purpose, introduced 
> > > behavioural change for Kconfig symbols: we no longer able to 
> > > select tracing support on PPC32 (because IRQFLAGS_SUPPORT isn't 
> > > yet implemented).
> > 
> > Could you please solve this by implementing proper 
> > irqflag-tracing support? It's been available upstream for almost 
> > three years. It's needed for lockdep support as well, etc.
> 
> Breaking things via clean up patches is an interesting method of 
> encouraging something to implement. ;-)
>
> Surely I'll look into implementing irqflags tracing, but 
> considering that no one ever needed this for almost three years, 
> [...]

Weird, there's no lockdep support?

	Ingo
