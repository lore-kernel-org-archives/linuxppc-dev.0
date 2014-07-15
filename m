Return-Path: <rostedt@goodmis.org>
Received: from cdptpa-oedge-vip.email.rr.com
 (cdptpa-outbound-snat.email.rr.com [107.14.166.229])
 by lists.ozlabs.org (Postfix) with ESMTP id 542301A014F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 12:13:44 +1000 (EST)
Date: Mon, 14 Jul 2014 22:13:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Revert removing of _INIT_GLOBAL(), _STATIC()
 and _INIT_STATIC()
Message-ID: <20140714221334.4b6109e0@gandalf.local.home>
In-Reply-To: <1405389955.9343.48.camel@pasglop>
References: <20140714201204.7b6fcd8e@gandalf.local.home>
 <1405389955.9343.48.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 15 Jul 2014 12:05:55 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Mon, 2014-07-14 at 20:12 -0400, Steven Rostedt wrote:
> > I wanted to test some new ftrace code on my PASemi electra powerpc box.
> > But unfortunately it failed to build. It failed with this:
> > 
> >   LD      init/built-in.o
> > arch/powerpc/kernel/head_64.o:arch/powerpc/kernel/exceptions-64s.S:874:
> >   relocation truncated to fit: R_PPC64_REL14 against `.text'+1c90
> > Makefile:864: recipe for target 'vmlinux' failed
> 
> Weird ... what are your gcc and binutils versions ? Smells like a
> toolchain issue to me but I need to dig a bit more. Doesn't hit any
> of my test configs here.
> 

I built it from scratch from the mainline source repos.

dist-ppc-gcc (GCC) 4.6.0
Copyright (C) 2011 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


GNU assembler (GNU Binutils) 2.21
Copyright 2010 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License version 3 or later.
This program has absolutely no warranty.
This assembler was configured for a target of `powerpc64-unknown-linux'.


-- Steve
