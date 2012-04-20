Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:70:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D0176B7041
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2012 19:17:20 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/3] powerpc/mpic: Properly set default triggers
References: <1334892657.31646.2.camel__44318.4292679236$1334892821$gmane$org@pasglop>
Date: Fri, 20 Apr 2012 11:17:11 +0200
In-Reply-To: <1334892657.31646.2.camel__44318.4292679236$1334892821$gmane$org@pasglop>
 (Benjamin Herrenschmidt's message of "Fri, 20 Apr 2012 13:30:57
 +1000")
Message-ID: <m2obqmrcdk.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> This gets rid of the unused default senses array, and replaces the
> incorrect use of IRQ_TYPE_NONE with the new IRQ_TYPE_DEFAULT for
> the initial set_trigger() call when mapping an interrupt.
>
> This in turn makes us read the HW state and update the irq desc
> accordingly.

That fixes the interrupt problem for me.  The only regression left is
the spurious interrupts.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
