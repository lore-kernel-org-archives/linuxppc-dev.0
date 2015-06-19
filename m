Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 325F61A1031
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 22:01:54 +1000 (AEST)
Date: Fri, 19 Jun 2015 14:01:50 +0200
From: Torsten Duwe <duwe@lst.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jiri Kosina <jkosina@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 1/4] ppc64 FTRACE_WITH_REGS implementation
Message-ID: <20150619120150.GB3805@lst.de>
References: <20150611095338.GA4492@lst.de> <20150618161727.GA6546@lst.de>
 <20150618162107.GB6546@lst.de> <20150618124900.7a57dff7@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150618124900.7a57dff7@gandalf.local.home>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 18, 2015 at 12:49:00PM -0400, Steven Rostedt wrote:
> On Thu, 18 Jun 2015 18:21:07 +0200
> Torsten Duwe <duwe@lst.de> wrote:
> 
> > +	
> >  _GLOBAL(ftrace_stub)
> > +	nop
> > +	nop
> > +.localentry ftrace_stub,.-ftrace_stub	
> 
> You might want to run checkpatch and fix your whitespace errors.

Right. Will do.
Thanks,

	Torsten
