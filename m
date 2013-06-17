Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id AD64B2C0299
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2013 23:51:53 +1000 (EST)
Message-ID: <1371477109.18733.7.camel@gandalf.local.home>
Subject: Re: Regression in RCU subsystem in latest mainline kernel
From: Steven Rostedt <rostedt@goodmis.org>
To: Rojhalat Ibrahim <imr@rtschenk.de>
Date: Mon, 17 Jun 2013 09:51:49 -0400
In-Reply-To: <1558776.vQIgbXvFW8@pcimr>
References: <1626500.7WAVXjfS9F@pcimr> <1371261741.21896.20.camel@pasglop>
 <1371262654.9844.340.camel@gandalf.local.home> <1558776.vQIgbXvFW8@pcimr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulmck@linux.vnet.ibm.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-06-17 at 15:21 +0200, Rojhalat Ibrahim wrote:
> On Friday 14 June 2013 22:17:34 Steven Rostedt wrote:
> > On Sat, 2013-06-15 at 12:02 +1000, Benjamin Herrenschmidt wrote:
> > > On Fri, 2013-06-14 at 17:06 -0400, Steven Rostedt wrote:
> > > > I was pretty much able to reproduce this on my PA Semi PPC box. Funny
> > > > thing is, when I type on the console, it makes progress. Anyway, it
> > > > seems that powerpc has an issue with irq_work(). I'll try to get some
> > > > time either tonight or next week to figure it out.
> > > 
> > > Does this help ?
> > 
> > It did for me. Rojhalat, did this fix your issue too?
> > 
> 
> FWIW, since the fix is already applied, but it fixes my problem too.
> 

Thanks for the update. Yeah, Ben was about to send a queue to Linus, and
as this proved to fix it for me, he felt that it needed to go in that
queue instead of waiting for an update.

But I do appreciate the update as I wasn't 100% that this would fix the
problem for you too.

-- Steve
