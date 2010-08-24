Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C823EB70B4
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Aug 2010 16:33:25 +1000 (EST)
Subject: Re: [PATCH] [powerpc] Wire up fanotify_init, fanotify_mark,
	prlimit64 syscalls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <201008231552.07013.arnd@arndb.de>
References: <m28w42prae.fsf@igel.home> <201008191937.20405.arnd@arndb.de>
	<m2tymqp7op.fsf@igel.home>  <201008231552.07013.arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 24 Aug 2010 16:33:04 +1000
Message-ID: <1282631584.22370.523.camel@pasglop>
Mime-Version: 1.0
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

On Mon, 2010-08-23 at 15:52 +0200, Arnd Bergmann wrote:
> On Friday 20 August 2010, Andreas Schwab wrote:
> > See arch/powerpc/platforms/cell/spu_callbacks.c.
> > 
> >  * 4. They are optional and we can't rely on them being
> >  *    linked into the kernel. Unfortunately, the cond_syscall
> >  *    helper does not work here as it does not add the necessary
> >  *    opd symbols:
> 
> Right. I should blame the person that wrote this comment.
> If only I could remember who that was.

Regardless of the outcome of that, I'm merging Andreas patch. We can
always add SPU bindings if we feel like it later.

Cheers,
Ben.
