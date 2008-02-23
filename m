Return-Path: <phdm@macqel.be>
Received: from mail.macqel.be (mail.macqel.be [194.78.208.39])
	by ozlabs.org (Postfix) with ESMTP id 78259DDE00
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 21:17:08 +1100 (EST)
Date: Sat, 23 Feb 2008 11:17:07 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: MPC8540 : What's "SPE used in kernel" ?
Message-ID: <20080223101707.GA7194@10.1.86.20>
References: <20080221123534.GA17716@ingate.macqel>
	<20080222095022.GA635@ingate.macqel>
	<08A7CD2B-27EA-4C97-9220-314E36BBBAA6@freescale.com>
	<20080223092458.GA6873@10.1.86.20>
	<1203760269.13162.11.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1203760269.13162.11.camel@johannes.berg>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Johanness,

On Sat, Feb 23, 2008 at 10:51:08AM +0100, Johannes Berg wrote:
> 
> > My first trial used ARCH=ppc and caused this infinity of "SPE used in kernel"
> > messages, but I then recompiled linux with ARCH=powerpc.  With the message
> > not ifdef'ed out, this second kernel does not emit "SPE used in kernel"
> > messages,
> 
> If I were to venture a guess I'd point to the fact that the arch/powerpc
> Makefile contains
> 
> # No SPE instruction when building kernel
> KBUILD_CFLAGS += $(call cc-option,-mno-spe)  

OK, that's a good point.

But as I said in the same mail, processes still dies unexpectedly.

> 
> while the arch/ppc one doesn't.
> 
> johannes

Philippe
