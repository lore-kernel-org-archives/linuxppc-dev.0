Return-Path: <sam@ravnborg.org>
Received: from pqueuea.post.tele.dk (pqueuea.post.tele.dk [193.162.153.9])
	by ozlabs.org (Postfix) with ESMTP id 46624DDDAD
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Feb 2009 07:48:57 +1100 (EST)
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by pqueuea.post.tele.dk (Postfix) with ESMTP id BDE41DBE4B
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Feb 2009 20:56:29 +0100 (CET)
Date: Sat, 14 Feb 2009 20:58:10 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] Makefile: Include arch Makefiles as late as possible
Message-ID: <20090214195810.GC1241@uranus.ravnborg.org>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru>
	<20090204150835.GA30027@oksana.dev.rtsoft.ru>
	<20090204212612.GN22608@elte.hu> <1234324294.29851.0.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1234324294.29851.0.camel@pasglop>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 11, 2009 at 02:51:34PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2009-02-04 at 22:26 +0100, Ingo Molnar wrote:
> > > +include $(srctree)/arch/$(SRCARCH)/Makefile
> > > +
> > >  # arch Makefile may override CC so keep this after arch Makefile is
> > included
> > >  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC)
> > -print-file-name=include)
> > >  CHECKFLAGS     += $(NOSTDINC_FLAGS)
> > > -- 
> > 
> > this patch is really for Sam to judge - Cc:-ed him.
> 
> Sam ? I have a few more powerpc patches depending on that one... so I'd
> like to know if it's totally doomed or not :-)

See my answer to the mail from Ingo.

We really need to do this on Kconfig level it at all possible.

	Sam
