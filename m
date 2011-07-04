Return-Path: <fweisbec@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 05B7EB6F73
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  4 Jul 2011 23:29:22 +1000 (EST)
Received: by vxb40 with SMTP id 40so4014037vxb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 04 Jul 2011 06:29:18 -0700 (PDT)
Date: Mon, 4 Jul 2011 15:29:14 +0200
From: Frederic Weisbecker <fweisbec@gmail.com>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/6] hw_breakpoints: Migrate breakpoint conditional build
	under new config
Message-ID: <20110704132912.GB5551@somewhere>
References: <1306273947-8410-1-git-send-email-fweisbec@gmail.com>
	<1306273947-8410-3-git-send-email-fweisbec@gmail.com>
	<20110704132746.GA2963@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110704132746.GA2963@in.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Mundt <lethal@linux-sh.org>,
	linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 04, 2011 at 06:57:46PM +0530, K.Prasad wrote:
> On Tue, May 24, 2011 at 11:52:23PM +0200, Frederic Weisbecker wrote:
> > Migrate conditional hw_breakpoint code compilation under
> > the new config to prepare for letting the user chose whether
> > or not to build this feature
> > 
> > Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
> > Acked-by: Will Deacon <will.deacon@arm.com>
> > Cc: Ingo Molnar <mingo@elte.hu>
> > Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > Cc: Prasad <prasad@linux.vnet.ibm.com>
> > Cc: Paul Mundt <lethal@linux-sh.org>
> > ---
> >  arch/arm/include/asm/hw_breakpoint.h     |    4 ++--
> >  arch/arm/include/asm/processor.h         |    2 +-
> >  arch/arm/kernel/Makefile                 |    2 +-
> >  arch/arm/kernel/entry-header.S           |    2 +-
> >  arch/arm/kernel/ptrace.c                 |    4 ++--
> >  arch/powerpc/include/asm/cputable.h      |    4 ++--
> >  arch/powerpc/include/asm/hw_breakpoint.h |    6 +++---
> >  arch/powerpc/include/asm/processor.h     |    4 ++--
> >  arch/powerpc/kernel/Makefile             |    2 +-
> >  arch/powerpc/kernel/process.c            |   18 +++++++++---------
> >  arch/powerpc/kernel/ptrace.c             |   13 +++++++------
> >  arch/powerpc/lib/Makefile                |    2 +-
> >  arch/sh/kernel/Makefile                  |    2 +-
> >  arch/sh/kernel/cpu/sh4a/Makefile         |    2 +-
> >  include/linux/hw_breakpoint.h            |    6 +++---
> >  include/linux/perf_event.h               |    4 ++--
> >  include/linux/ptrace.h                   |    6 +++---
> >  include/linux/sched.h                    |    2 +-
> >  kernel/events/Makefile                   |    2 +-
> >  kernel/events/core.c                     |    4 ++--
> >  kernel/ptrace.c                          |    4 ++--
> >  samples/Kconfig                          |    2 +-
> >  22 files changed, 49 insertions(+), 48 deletions(-)
> > 
> 
> Making the hardware breakpoint patches modular has always been a goal.
> I've looked at the PowerPC parts of the code and they look harmless.
> 
> Acked-by: K.Prasad <prasad@linux.vnet.ibm.com>

Great!

I'll push that soon, thanks guys for your acks!
