Return-Path: <SRS0=Vz7S=2J=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXgVx1fSXzDqHH
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Mar 2017 01:11:52 +1100 (AEDT)
Date: Tue, 28 Feb 2017 09:11:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 1/2] powerpc: split ftrace bits into a separate file
Message-ID: <20170228091147.69b836a8@gandalf.local.home>
In-Reply-To: <87wpcbota8.fsf@concordia.ellerman.id.au>
References: <cover.1487702678.git.naveen.n.rao@linux.vnet.ibm.com>
 <d2058affbf317d0f72e2df970f97b7b53ade47cb.1487702678.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170227103650.0955c5eb@gandalf.local.home>
 <87wpcbota8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 28 Feb 2017 15:04:15 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

kernel/trace/ftrace.c more obvious.
> 
> I don't know if it's really worth keeping the names the same across
> arches, especially as we already have:
> 
>   arch/arm64/kernel/entry-ftrace.S
>   arch/arm/kernel/entry-ftrace.S
>   arch/blackfin/kernel/ftrace-entry.S
>   arch/metag/kernel/ftrace_stub.S
> 
> But we can rename it if you feel strongly about it.

Hmm, perhaps "entry-ftrace.S" would be the better name. I never liked
the "mcount.S" name.

-- Steve
