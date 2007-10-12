Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 4E379DDE3E
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Oct 2007 07:32:32 +1000 (EST)
Date: Fri, 12 Oct 2007 14:32:39 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: Override timer interrupt
Message-ID: <20071012213239.GC22894@mag.az.mvista.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B037D4BB7@ismail.innsys.innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B037D4BB7@ismail.innsys.innovsys.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 12, 2007 at 03:49:02PM -0500, Rune Torgersen wrote:
> Is there an easy way to use something other than the decrementer for the
> timer interrupt?
> 
> Reason i'm asking is tha t on our board, the decrementer cannot be
> divided to 1khz evenly, so we have rounding errors for time, but we do
> have a 1KHz timer interrupt from an FPGA that is source of a T1 clock.
> 
> Right now I let the decrementer interrupt do nothing, and made my own
> timer interrupt handler that calls the stuff the timer_interrupt usually
> does. 
> 
> This works, but there are some instability (ie unexplained hangs) that
> showed up when I did this.

I just responded to you on -embedded with this:

"Check out the clocksource stuff.  It let's you set up numerous clock
 sources and set the rating of each one.  You can start looking in
 arch/powerpc/kernel/time.c for example code."

Mark
