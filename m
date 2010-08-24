Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 2263CB70B4
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Aug 2010 17:58:14 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] [powerpc] Wire up fanotify_init, fanotify_mark,
	prlimit64 syscalls
Date: Tue, 24 Aug 2010 09:58:05 +0200
References: <m28w42prae.fsf@igel.home> <201008231552.07013.arnd@arndb.de>
	<1282631584.22370.523.camel@pasglop>
In-Reply-To: <1282631584.22370.523.camel@pasglop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201008240958.06094.arnd@arndb.de>
Cc: Linuxppc-dev@ozlabs.org, Andreas Schwab <schwab@linux-m68k.org>,
	Arnd Bergmann <arndbergmann@googlemail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 24 August 2010, Benjamin Herrenschmidt wrote:
> On Mon, 2010-08-23 at 15:52 +0200, Arnd Bergmann wrote:
> > On Friday 20 August 2010, Andreas Schwab wrote:
> > > See arch/powerpc/platforms/cell/spu_callbacks.c.
> > > 
> > >  * 4. They are optional and we can't rely on them being
> > >  *    linked into the kernel. Unfortunately, the cond_syscall
> > >  *    helper does not work here as it does not add the necessary
> > >  *    opd symbols:
> > 
> > Right. I should blame the person that wrote this comment.
> > If only I could remember who that was.
> 
> Regardless of the outcome of that, I'm merging Andreas patch. We can
> always add SPU bindings if we feel like it later.

Sorry, I should have added a ';-)' or been clearer. The patch is good,
I wrote the comment that Andreas quoted and it's probably my own fault
that we never found a way to handle syscalls like this correctly from
the SPU.

	Arnd
