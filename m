Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411npb1DRZzF34L
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 00:23:50 +1000 (AEST)
Date: Thu, 7 Jun 2018 23:23:44 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, "H . Peter Anvin" <hpa@zytor.com>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Steven
 Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH -tip v5 07/27] powerpc/kprobes: Remove jprobe
 powerpc implementation
Message-Id: <20180607232344.31785bad5ebcbe82dd381284@kernel.org>
In-Reply-To: <1528370755.shi1gq6h7g.naveen@linux.ibm.com>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
 <152812751377.10068.6090934299713110701.stgit@devbox>
 <1528370755.shi1gq6h7g.naveen@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 07 Jun 2018 17:01:23 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Masami Hiramatsu wrote:
> > Remove arch dependent setjump/longjump functions
> > and unused fields in kprobe_ctlblk for jprobes
> > from arch/powerpc. This also reverts commits
> > related __is_active_jprobe() function.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > ---
> >  arch/powerpc/include/asm/kprobes.h             |    2 -
> >  arch/powerpc/kernel/kprobes-ftrace.c           |   15 -------
> >  arch/powerpc/kernel/kprobes.c                  |   54 ------------------------
> >  arch/powerpc/kernel/trace/ftrace_64_mprofile.S |   39 ++---------------
> >  4 files changed, 5 insertions(+), 105 deletions(-)
> 
> LGTM.
> 
> Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Thanks Naveen!

> 
> - Naveen
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
