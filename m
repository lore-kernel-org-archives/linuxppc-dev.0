Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 422D01A127D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Dec 2015 11:22:04 +1100 (AEDT)
Date: Mon, 21 Dec 2015 19:21:56 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Michael Ellerman <michael@ellerman.id.au>
CC: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Paul Mackerras
 <paulus@samba.org>
Subject: Re: [PATCH] powerpc: warn on spurious irq events (but ratelimited)
Message-ID: <20151222002156.GB12458@windriver.com>
References: <1449538707-7867-1-git-send-email-paul.gortmaker@windriver.com>
 <CAP=VYLq_JQuPwAze73mFYco=9pK=rvYKabsvUewnoPdNVzCXXw@mail.gmail.com>
 <1450743048.27983.1.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1450743048.27983.1.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Re: [PATCH] powerpc: warn on spurious irq events (but ratelimited)] On 22/12/2015 (Tue 11:10) Michael Ellerman wrote:

> On Mon, 2015-12-21 at 18:18 -0500, Paul Gortmaker wrote:
> > On Mon, Dec 7, 2015 at 8:38 PM, Paul Gortmaker
> > <paul.gortmaker@windriver.com> wrote:
> > > It might be worth warning on spurious IRQ events; they might
> > > point someone at a bogus DTS value or similar.
> > > 

[...]

> > 
> > If we did decide we cared about this patch, then no need for "irq" above, as
> > we already know it is equal to NO_IRQ.
> 
> I'm not convinced it's worth printing, we already have a counter in proc.
> 
> I think it's more likely to just lead to console spam.
> 
> But maybe I'm wrong and you can convince me otherwise :)

I'm not sure I can even convince myself, let alone others.   :)

Feel free to bin it.

Paul.
--

> 
> cheers
> 
