Return-Path: <srostedt@redhat.com>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id D8191DDDAB
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 01:12:11 +1100 (EST)
Subject: Re: [PATCH 1/3] Makefile: Include arch Makefiles as late as possible
From: Steven Rostedt <srostedt@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20090211132338.GQ16535@elte.hu>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru>
	<20090204150835.GA30027@oksana.dev.rtsoft.ru>
	<20090204212612.GN22608@elte.hu> <1234324294.29851.0.camel@pasglop>
	<20090211132338.GQ16535@elte.hu>
Content-Type: text/plain
Date: Wed, 11 Feb 2009 09:11:42 -0500
Message-Id: <1234361502.31601.0.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2009-02-11 at 14:23 +0100, Ingo Molnar wrote:
> * Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Wed, 2009-02-04 at 22:26 +0100, Ingo Molnar wrote:
> > > > +include $(srctree)/arch/$(SRCARCH)/Makefile
> > > > +
> > > >  # arch Makefile may override CC so keep this after arch Makefile is
> > > included
> > > >  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC)
> > > -print-file-name=include)
> > > >  CHECKFLAGS     += $(NOSTDINC_FLAGS)
> > > > -- 
> > > 
> > > this patch is really for Sam to judge - Cc:-ed him.
> > 
> > Sam ? I have a few more powerpc patches depending on that one... so I'd
> > like to know if it's totally doomed or not :-)
> 
> Well, toplevel Makefile changes are not to be taken lightly :-)
> 
> Looks good to me but it's handy to have Sam's Ack on it too.
> 

Someone on IRC said that Sam is on vacation. This could take a while for
an ACK.


-- Steve
