Return-Path: <srostedt@redhat.com>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id 9B83EDDD0C
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2009 14:10:23 +1100 (EST)
Subject: Re: [PATCH] tracing: Fix TRACING_SUPPORT dependency
From: Steven Rostedt <srostedt@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20090320195743.GA25147@elte.hu>
References: <20090320150914.GA22769@oksana.dev.rtsoft.ru>
	<20090320190428.GD6224@elte.hu>
	<20090320193904.GA13707@oksana.dev.rtsoft.ru>
	<20090320195743.GA25147@elte.hu>
Content-Type: text/plain
Date: Fri, 20 Mar 2009 23:09:58 -0400
Message-Id: <1237604998.17367.3.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Ug, My Red Hat email was not being updated. I totally missed this
thread.

On Fri, 2009-03-20 at 20:57 +0100, Ingo Molnar wrote:
> * Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> 
> > On Fri, Mar 20, 2009 at 08:04:28PM +0100, Ingo Molnar wrote:
> > > 
> > > * Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> > > 
> > > > commit 40ada30f9621fbd831ac2437b9a2a399aad34b00 ("tracing: clean 
> > > > up menu"), despite the "clean up" in its purpose, introduced 
> > > > behavioural change for Kconfig symbols: we no longer able to 
> > > > select tracing support on PPC32 (because IRQFLAGS_SUPPORT isn't 
> > > > yet implemented).
> > > 
> > > Could you please solve this by implementing proper 
> > > irqflag-tracing support? It's been available upstream for almost 
> > > three years. It's needed for lockdep support as well, etc.
> > 
> > Breaking things via clean up patches is an interesting method of 
> > encouraging something to implement. ;-)
> >
> > Surely I'll look into implementing irqflags tracing, but 
> > considering that no one ever needed this for almost three years, 
> > [...]
> 
> Weird, there's no lockdep support?

I've discussed this with several people before. lockdep exists for
PPC64, but apparently it does not work for PPC32. There's been ongoing
work in this area, but unfortunately, nothing stable has come out of it.

I believe Dale was the last one to be working on this.

-- Steve
