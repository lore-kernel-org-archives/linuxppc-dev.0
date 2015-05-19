Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl2.internode.on.net (ipmail06.adl2.internode.on.net
 [150.101.137.129])
 by lists.ozlabs.org (Postfix) with ESMTP id C37951A0017
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 15:10:00 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 4/9] hvc: Convert to using interrupts instead of opal
 events
Date: Tue, 19 May 2015 15:09:58 +1000
Message-ID: <1539369.udhAakg3JC@mexican>
In-Reply-To: <1432010019.8339.4.camel@ellerman.id.au>
References: <1431662804-16851-1-git-send-email-alistair@popple.id.au>
 <1431662804-16851-5-git-send-email-alistair@popple.id.au>
 <1432010019.8339.4.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 19 May 2015 14:33:39 Michael Ellerman wrote:
> On Fri, 2015-05-15 at 14:06 +1000, Alistair Popple wrote:
> > Convert the opal hvc driver to use the new irqchip to register for
> > opal events. As older firmware versions may not have device tree
> > bindings for the interrupt parent we just use a hardcoded hwirq based
> > on the event number.
> 
> This is still breaking the mambo skiboot test for me.

As in you still can't get to userspace?

You probably need http://patchwork.ozlabs.org/patch/472202/ which fixes a bug 
in skiboot.

> Nothing obvious on the console
> 
> cheers
