Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7FB1A1A03CA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2015 01:57:05 +1000 (AEST)
Date: Mon, 8 Jun 2015 17:57:01 +0200
From: Torsten Duwe <duwe@lst.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Jiri Kosina <jkosina@suse.cz>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] ppc64 ftrace implementation
Message-ID: <20150608155701.GA23784@lst.de>
References: <20150513161100.GA1619@lst.de>
 <1431653687.13498.1.camel@ellerman.id.au> <20150515084542.GA20453@suse.de>
 <20150516080534.GA27059@lst.de>
 <alpine.LRH.2.00.1505181428360.2306@twin.jikos.cz>
 <1432006027.8339.3.camel@ellerman.id.au>
 <alpine.LNX.2.00.1505191150420.8186@pobox.suse.cz>
 <20150603130257.GA19424@lst.de> <20150603130829.GB19424@lst.de>
 <20150608113032.07544ece@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150608113032.07544ece@gandalf.local.home>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 08, 2015 at 11:30:32AM -0400, Steven Rostedt wrote:
> 
> Why are your patches all as replies?

Because I cared too much about the threading and the series that the
"Re:" escaped me.

> > Implement ftrace on ppc64
> 
> What do you mean "Implement ftrace on ppc64"? It's already implemented.

Sorry, too deep in the details. It's DYNAMIC_FTRACE_WITH_REGS, actually.
Using gcc's -mprofile-kernel to call into ftrace...

> I'm not even going to bother looking at this patch because I have no
> idea what its purpose is.

Understandable ;-)

So: Implement DYNAMIC_FTRACE_WITH_REGS, in order to prepare for live patching.
Other obvious things I forgot to mention?

	Torsten
