Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EFB10B7D11
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Apr 2010 20:09:58 +1000 (EST)
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by fallback.mail.elte.hu with esmtp (Exim) id 1O5Ew6-0008BX-5q
	from <mingo@elte.hu>
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Apr 2010 11:12:34 +0200
Date: Fri, 23 Apr 2010 11:11:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [GIT PULL] Perf probe support for PowerPC, from Ian Munsie
Message-ID: <20100423091158.GA6078@elte.hu>
References: <20100423003251.GA2420@brick.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100423003251.GA2420@brick.ozlabs.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linuxppc-dev@ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Masami Hiramatsu <mhiramat@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Paul Mackerras <paulus@samba.org> wrote:

> Ingo,
> 
> Please pull my perf.git master branch:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulus/perf.git master
> 
> It has two commits from Ian Munsie that allow us to access local
> variables with perf probe on PowerPC.  We also need a commit in Ben's
> powerpc-next branch for it to function, but it compiles without that.
> 
> Thanks,
> Paul.
> 
> ---
> 
> The following changes since commit 6eca8cc35b50af1037bc919106dd6dd332c959c2:
>   Frederic Weisbecker (1):
>         perf: Fix perf probe build error
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulus/perf.git master
> 
> Ian Munsie (2):
>       perf: Move arch specific code into separate arch directory
>       perf probe: Add PowerPC DWARF register number mappings
> 
>  tools/perf/Makefile                       |   36 ++++++++++--
>  tools/perf/arch/powerpc/Makefile          |    4 +
>  tools/perf/arch/powerpc/util/dwarf-regs.c |   88 +++++++++++++++++++++++++++++
>  tools/perf/arch/x86/Makefile              |    4 +
>  tools/perf/arch/x86/util/dwarf-regs.c     |   75 ++++++++++++++++++++++++
>  tools/perf/util/include/dwarf-regs.h      |    8 +++
>  tools/perf/util/probe-finder.c            |   55 +-----------------
>  7 files changed, 211 insertions(+), 59 deletions(-)
>  create mode 100644 tools/perf/arch/powerpc/Makefile
>  create mode 100644 tools/perf/arch/powerpc/util/dwarf-regs.c
>  create mode 100644 tools/perf/arch/x86/Makefile
>  create mode 100644 tools/perf/arch/x86/util/dwarf-regs.c
>  create mode 100644 tools/perf/util/include/dwarf-regs.h

Pulled, thanks a lot Paul!

	Ingo
