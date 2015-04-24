Return-Path: <rostedt@goodmis.org>
Received: from smtprelay.hostedemail.com (smtprelay0221.hostedemail.com
 [216.40.44.221])
 by lists.ozlabs.org (Postfix) with ESMTP id D658F1A0C3D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 00:32:39 +1000 (AEST)
Date: Fri, 24 Apr 2015 10:32:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powerpc/ftrace: add powerpc timebase as a trace
 clock source
Message-ID: <20150424103232.30568a76@gandalf.local.home>
In-Reply-To: <1429865684-6214-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
References: <1429865684-6214-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 24 Apr 2015 14:24:44 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Add a new powerpc-specific trace clock using the timebase register,
> similar to x86-tsc. This gives us
> - a fast, monotonic, hardware clock source for trace entries, and
> - a clock that can be used to correlate events across cpus as well as across
>   hypervisor and guests.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
> Changes since v1:
> - removed unnecessary #ifdef in trace_clock.h
> - changed config build dependency for trace_clock.o from TRACE_CLOCK to TRACING
> 

Looks fine to me.

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

> 
>  Documentation/trace/ftrace.txt         |  5 +++++
>  arch/powerpc/include/asm/Kbuild        |  1 -
>  arch/powerpc/include/asm/trace_clock.h | 19 +++++++++++++++++++
>  arch/powerpc/kernel/Makefile           |  1 +
>  arch/powerpc/kernel/trace_clock.c      | 15 +++++++++++++++
>  5 files changed, 40 insertions(+), 1 deletion(-)
>  create mode 100644 arch/powerpc/include/asm/trace_clock.h
>  create mode 100644 arch/powerpc/kernel/trace_clock.c
> 
