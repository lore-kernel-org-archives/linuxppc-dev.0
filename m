Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id A2B16DDF22
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Oct 2007 08:40:25 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so438920wag
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Oct 2007 15:40:24 -0700 (PDT)
Message-ID: <fa686aa40710241540y498b0c92le63920862d6b9315@mail.gmail.com>
Date: Wed, 24 Oct 2007 16:40:23 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Matt Mackall" <mpm@selenic.com>
Subject: Re: Apparent kernel bug with GDB on ppc405
In-Reply-To: <fa686aa40710241539r792380dam62ea820a48dab62e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071024194640.GB19691@waste.org>
	<fa686aa40710241328x77435cc1lf09cac730b0ce5ac@mail.gmail.com>
	<20071024204215.GC19691@waste.org> <20071024215421.GF19691@waste.org>
	<fa686aa40710241527j1a316760lf36d512eb625810f@mail.gmail.com>
	<20071024223250.GI19691@waste.org>
	<fa686aa40710241539r792380dam62ea820a48dab62e@mail.gmail.com>
Cc: gdb@sourceware.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 10/24/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> > Not completely implausible, but a) why isn't this seen on basically
> > every machine with software TLB? b) why does -local- GDB, which is
> > presumably doing much less work than gdbserver + network stack, not fail?
>
> a) I don't know.... very odd.
>
> b) gdb is big.  It probably touches far more pages (via library calls)
> than gdbserver.  The network stack is also big, but it's probably more
> localized too.
>
> Niceing down the host also makes sense because if the PC is being slow
> then the target may go off and run other things while between setting
> the breakpoint and getting the 'go' command.
>
> Can you grab a snapshot of the TLB before and after setting the breakpoint?

Or; probably more relevant, before and after the page copy?

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
