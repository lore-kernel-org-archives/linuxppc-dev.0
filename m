Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 68188B6F70
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  4 Jul 2011 23:28:03 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp02.au.ibm.com (8.14.4/8.13.1) with ESMTP id p64DLp80016591
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2011 23:21:51 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p64DQa061191944
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2011 23:26:37 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p64DRpDj019041
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2011 23:27:52 +1000
Date: Mon, 4 Jul 2011 18:57:46 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 2/6] hw_breakpoints: Migrate breakpoint conditional build
	under new config
Message-ID: <20110704132746.GA2963@in.ibm.com>
References: <1306273947-8410-1-git-send-email-fweisbec@gmail.com>
	<1306273947-8410-3-git-send-email-fweisbec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306273947-8410-3-git-send-email-fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Mundt <lethal@linux-sh.org>,
	linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 24, 2011 at 11:52:23PM +0200, Frederic Weisbecker wrote:
> Migrate conditional hw_breakpoint code compilation under
> the new config to prepare for letting the user chose whether
> or not to build this feature
> 
> Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Prasad <prasad@linux.vnet.ibm.com>
> Cc: Paul Mundt <lethal@linux-sh.org>
> ---
>  arch/arm/include/asm/hw_breakpoint.h     |    4 ++--
>  arch/arm/include/asm/processor.h         |    2 +-
>  arch/arm/kernel/Makefile                 |    2 +-
>  arch/arm/kernel/entry-header.S           |    2 +-
>  arch/arm/kernel/ptrace.c                 |    4 ++--
>  arch/powerpc/include/asm/cputable.h      |    4 ++--
>  arch/powerpc/include/asm/hw_breakpoint.h |    6 +++---
>  arch/powerpc/include/asm/processor.h     |    4 ++--
>  arch/powerpc/kernel/Makefile             |    2 +-
>  arch/powerpc/kernel/process.c            |   18 +++++++++---------
>  arch/powerpc/kernel/ptrace.c             |   13 +++++++------
>  arch/powerpc/lib/Makefile                |    2 +-
>  arch/sh/kernel/Makefile                  |    2 +-
>  arch/sh/kernel/cpu/sh4a/Makefile         |    2 +-
>  include/linux/hw_breakpoint.h            |    6 +++---
>  include/linux/perf_event.h               |    4 ++--
>  include/linux/ptrace.h                   |    6 +++---
>  include/linux/sched.h                    |    2 +-
>  kernel/events/Makefile                   |    2 +-
>  kernel/events/core.c                     |    4 ++--
>  kernel/ptrace.c                          |    4 ++--
>  samples/Kconfig                          |    2 +-
>  22 files changed, 49 insertions(+), 48 deletions(-)
> 

Making the hardware breakpoint patches modular has always been a goal.
I've looked at the PowerPC parts of the code and they look harmless.

Acked-by: K.Prasad <prasad@linux.vnet.ibm.com>

Thanks,
K.Prasad
