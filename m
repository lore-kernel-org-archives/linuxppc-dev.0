Return-Path: <SRS0=hLom=2T=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vftfN55Y9zDqXx
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Mar 2017 03:54:52 +1100 (AEDT)
Date: Fri, 10 Mar 2017 11:54:45 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H.
 Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 1/2] powerpc: split ftrace bits into a separate file
Message-ID: <20170310115445.4f7e4a2b@gandalf.local.home>
In-Reply-To: <20170310160853.GD20400@naverao1-tp.localdomain>
References: <cover.1487702678.git.naveen.n.rao@linux.vnet.ibm.com>
 <d2058affbf317d0f72e2df970f97b7b53ade47cb.1487702678.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170227103650.0955c5eb@gandalf.local.home>
 <87wpcbota8.fsf@concordia.ellerman.id.au>
 <20170228091147.69b836a8@gandalf.local.home>
 <871sugkogi.fsf@concordia.ellerman.id.au>
 <20170310104530.357213c1@gandalf.local.home>
 <20170310160853.GD20400@naverao1-tp.localdomain>
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

On Fri, 10 Mar 2017 21:38:53 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> On 2017/03/10 10:45AM, Steven Rostedt wrote:
> > On Thu, 02 Mar 2017 20:38:53 +1100
> > Michael Ellerman <mpe@ellerman.id.au> wrote:

> > > So if we drop that we're left with ftrace.S - which seems perfect to me.  
> > 
> > Yeah, I agree. But then there's the problem that ftrace.c and ftrace.S
> > will get the same ftrace.o. Maybe make it ftrace-hook.S ?  
> 
> I've avoided that issue by naming the files ftrace_32.S and ftrace_64.S 
> (which gets further split up).

That's what I looked at doing for x86 as well. But not all archs have
32 / 64 splits. Should we look to have something that all archs can be
consistent with?

-- Steve
