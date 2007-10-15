Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A3A60DDE07
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 19:26:02 +1000 (EST)
Subject: Re: [RFC/PATCH 2/2] powerpc: irqtrace support to 64-bit powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1192437681.3349.12.camel@johannes.berg>
References: <20071015072826.2D541DDE16@ozlabs.org>
	<1192437681.3349.12.camel@johannes.berg>
Content-Type: text/plain
Date: Mon, 15 Oct 2007 19:25:48 +1000
Message-Id: <1192440348.11795.9.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> 
> > --- linux-work.orig/include/asm-powerpc/irqflags.h	2007-10-15 17:10:12.000000000 +1000
> > +++ linux-work/include/asm-powerpc/irqflags.h	2007-10-15 17:11:09.000000000 +1000
>  
> >  /*
> > - * Do the CPU's IRQ-state tracing from assembly code. We call a
> > - * C function, so save all the C-clobbered registers:
> > + * Most of the CPU's IRQ-state tracing is done from assembly code; we
> > + * have to call a C function so call a wrapper that saves all the
> > + * C-clobbered registers.
> >   */
> 
> That comment is now wrong, it should probably be removed.

Ah yes, it's stale, I'll get rid of it. Thanks.

Ben.
