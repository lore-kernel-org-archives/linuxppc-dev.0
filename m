Return-Path: <SRS0=Qr/Y=2Y=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjsSG4NfQzDqGk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 00:11:26 +1100 (AEDT)
Date: Wed, 15 Mar 2017 09:11:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H.
 Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 1/2] powerpc: split ftrace bits into a separate file
Message-ID: <20170315091116.2a59c39f@gandalf.local.home>
In-Reply-To: <20170315090516.GE20400@naverao1-tp.localdomain>
References: <cover.1487702678.git.naveen.n.rao@linux.vnet.ibm.com>
 <d2058affbf317d0f72e2df970f97b7b53ade47cb.1487702678.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170227103650.0955c5eb@gandalf.local.home>
 <87wpcbota8.fsf@concordia.ellerman.id.au>
 <20170228091147.69b836a8@gandalf.local.home>
 <871sugkogi.fsf@concordia.ellerman.id.au>
 <20170310104530.357213c1@gandalf.local.home>
 <20170310160853.GD20400@naverao1-tp.localdomain>
 <20170310115445.4f7e4a2b@gandalf.local.home>
 <20170315090516.GE20400@naverao1-tp.localdomain>
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

On Wed, 15 Mar 2017 14:35:16 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> I don't have a strong opinion about this, but I feel that x86 can simply 
> use ftrace_64.S, seeing as the current name is mcount_64.S.
> 
> Other architectures could do something similar too, or fall back to 
> ftrace_hook.S. That way, all ftrace low-level code can simply be 
> referred to as arch/*/ftrace_*.S

Just to clarify, I'm currently working on patches to clean up the
ftrace.S code in x86, and I renamed mcount_64.S to ftrace_64.S. I'm
also moving the ftrace code out of entry_32.S into a ftrace_32.S file
as well. Patches will hopefully be posted soon.

-- Steve
