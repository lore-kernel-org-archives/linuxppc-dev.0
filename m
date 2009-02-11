Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E7B21DDDA5
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 15:03:09 +1100 (EST)
Subject: Re: [PATCH 1/3] Makefile: Include arch Makefiles as late as possible
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20090204212612.GN22608@elte.hu>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru>
	<20090204150835.GA30027@oksana.dev.rtsoft.ru>
	<20090204212612.GN22608@elte.hu>
Content-Type: text/plain
Date: Wed, 11 Feb 2009 14:51:34 +1100
Message-Id: <1234324294.29851.0.camel@pasglop>
Mime-Version: 1.0
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-02-04 at 22:26 +0100, Ingo Molnar wrote:
> > +include $(srctree)/arch/$(SRCARCH)/Makefile
> > +
> >  # arch Makefile may override CC so keep this after arch Makefile is
> included
> >  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC)
> -print-file-name=include)
> >  CHECKFLAGS     += $(NOSTDINC_FLAGS)
> > -- 
> 
> this patch is really for Sam to judge - Cc:-ed him.

Sam ? I have a few more powerpc patches depending on that one... so I'd
like to know if it's totally doomed or not :-)

Cheers,
Ben.
