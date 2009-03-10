Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 177ADDE32E
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 10:59:22 +1100 (EST)
Subject: Re: [PATCH v5] introduce macro spin_event_timeout()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20090310223753.GB26415@zod.rchland.ibm.com>
References: <1236723118-3577-1-git-send-email-timur@freescale.com>
	<49B6EAA4.9000803@freescale.com>
	<20090310223753.GB26415@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Wed, 11 Mar 2009 10:59:11 +1100
Message-Id: <1236729551.7086.26.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-03-10 at 18:37 -0400, Josh Boyer wrote:
> On Tue, Mar 10, 2009 at 05:33:08PM -0500, Scott Wood wrote:
> > Timur Tabi wrote:
> >> The macro spin_event_timeout() takes a condition and timeout value
> >> (in microseconds) as parameters.  It spins until either the condition is true
> >> or the timeout expires.  It returns zero if the timeout expires first, non-zero
> >> otherwise.
> >>
> >> This primary purpose of this macro is to poll on a hardware register until a
> >> status bit changes.  The timeout ensures that the loop still terminates if the
> >> bit doesn't change as expected.  This macro makes it easier for driver
> >> developers to perform this kind of operation properly.
> >>
> >> Signed-off-by: Timur Tabi <timur@freescale.com>
> >> ---
> >>
> >> v5: ported to arch/powerpc, made it powerpc-specific, eliminated udelay
> >
> > Why make it powerpc-specific?  This would be nice to have in  
> > arch-independent code.
> 
> That's just mean.  He already posted it to lkml and was told to make it
> powerpc specific by Alan.

And ? We can disagree with Alan...

Ben.
