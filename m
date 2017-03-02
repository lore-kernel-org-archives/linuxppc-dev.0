Return-Path: <SRS0=XfmF=2L=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vZ07k1X9czDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 04:44:49 +1100 (AEDT)
Date: Thu, 2 Mar 2017 12:44:41 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: David Daney <david.daney@cavium.com>, Jason Baron <jbaron@akamai.com>,
 Sachin Sant <sachinp@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, Chris Metcalf
 <cmetcalf@mellanox.com>, Ralf Baechle <ralf@linux-mips.org>, Russell King
 <linux@armlinux.org.uk>, Rabin Vincent <rabin@rab.in>, Paul Mackerras
 <paulus@samba.org>, Anton Blanchard <anton@samba.org>, Ingo Molnar
 <mingo@kernel.org>, Zhigang Lu <zlu@ezchip.com>
Subject: Re: [PATCH] module: set __jump_table alignment to 8
Message-ID: <20170302124441.0e2634e0@gandalf.local.home>
In-Reply-To: <8737ewexkp.fsf@concordia.ellerman.id.au>
References: <20170301220453.4756-1-david.daney@cavium.com>
 <87varsj6qc.fsf@concordia.ellerman.id.au>
 <8737ewexkp.fsf@concordia.ellerman.id.au>
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

On Thu, 02 Mar 2017 22:18:30 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Michael Ellerman <mpe@ellerman.id.au> writes:
> > David Daney <david.daney@cavium.com> writes:  
> >> Strict alignment became necessary with commit 3821fd35b58d
> >> ("jump_label: Reduce the size of struct static_key"), currently in
> >> linux-next, which uses the two least significant bits of pointers to
> >> __jump_table elements.  
> >
> > It would obviously be nice if this could go in before the commit that
> > exposes the breakage, but I guess that's problematic because Steve
> > doesn't want to rebase the tracing tree.
> >
> > Steve I think you've already sent your pull request for this cycle? So I
> > guess if this can go in your first batch of fixes?  
> 
> Ugh. Was looking at the wrong tree - Linus has already merged the commit
> in question, so the above is all moot.

No problem. I've got some other "fixes" to push to Linus. That's what
the -rc releases are for. To fix up breakage from the merge window ;-)

I'll pull this into my tree.

Thanks!

-- Steve
