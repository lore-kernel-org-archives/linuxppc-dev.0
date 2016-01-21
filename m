Return-Path: <jikos@kernel.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2C3051A001D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 08:29:19 +1100 (AEDT)
Date: Thu, 21 Jan 2016 22:29:13 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Torsten Duwe <duwe@lst.de>
cc: Michael Ellerman <mpe@ellerman.id.au>, Petr Mladek <pmladek@suse.com>,
 Denis Kirjanov <kda@linux-powerpc.org>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, live-patching@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 0/9] ftrace with regs + live patching for ppc64 LE
 (ABI v2)
In-Reply-To: <20160121151213.GB12374@lst.de>
Message-ID: <alpine.LNX.2.00.1601212227200.21446@cbobk.fhfr.pm>
References: <20151204152419.28E0D691D2@newverein.lst.de>
 <20160106141730.GL3178@pathway.suse.cz>
 <1453269803.14751.10.camel@ellerman.id.au>
 <alpine.LNX.2.00.1601211032430.21446@cbobk.fhfr.pm>
 <1453380891.28627.3.camel@ellerman.id.au> <20160121150633.GA12374@lst.de>
 <20160121151213.GB12374@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 21 Jan 2016, Torsten Duwe wrote:

> > mcount call sites looks normal on first sight...
> 
> Not quite.
> LR is not saved on the stack before the call.
> Argh!
> 
> Petr, this looks like 12 bytes offset for gcc-6.
> I think I can work around the rest.

Are we sure that gcc is doing the right thing here?

I am far from claiming understanding of ppc64 ABI, but from what Vojtech 
told me I understood that saving link register is necessary for (at least) 
graph tracer to work properly.

Thanks,

-- 
Jiri Kosina
SUSE Labs
