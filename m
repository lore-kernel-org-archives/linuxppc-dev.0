Return-Path: <SRS0=7aBp=2I=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vX5RX1Vr5zDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 02:36:56 +1100 (AEDT)
Date: Mon, 27 Feb 2017 10:36:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H.
 Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 1/2] powerpc: split ftrace bits into a separate file
Message-ID: <20170227103650.0955c5eb@gandalf.local.home>
In-Reply-To: <d2058affbf317d0f72e2df970f97b7b53ade47cb.1487702678.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1487702678.git.naveen.n.rao@linux.vnet.ibm.com>
 <d2058affbf317d0f72e2df970f97b7b53ade47cb.1487702678.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Wed, 22 Feb 2017 00:31:01 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> entry_*.S now includes a lot more than just kernel entry/exit code. As a
> first step at cleaning this up, let's split out the ftrace bits into
> separate files. Also move all related tracing code into a new trace/
> subdirectory.
> 
> No functional changes.

I wonder if we should stay consistent among archs, and call these files
"mcount_*.S". Or perhaps we should change x86 from mcount_64.S to
ftrace_64.S?

-- Steve
