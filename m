Return-Path: <Leonid@a-k-a.net>
Received: from mis011-1.exch011.intermedia.net
	(mis011-1.exch011.intermedia.net [64.78.21.221])
	by ozlabs.org (Postfix) with ESMTP id AA27567BB7
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Dec 2006 07:18:19 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: 2 PCI devices behind PCI bridge on Yosemite board.
Date: Thu, 30 Nov 2006 12:18:16 -0800
Message-ID: <406A31B117F2734987636D6CCC93EE3C99D709@ehost011-3.exch011.intermedia.net>
In-Reply-To: <456F3A16.7070204@freescale.com>
From: "Leonid" <Leonid@a-k-a.net>
To: "Scott Wood" <scottwood@freescale.com>
Cc: Balajee Premraj <balajee@a-k-a.net>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday, November 30, 2006 12:08 PM Scott Wood wrote:
> >=20
> > 1) I request interrupt and provide as interrupt handler empty
function:
> >=20
> > irqreturn_t snd_dream_interrupt(int irq, void *dev_id, struct
pt_regs
> > *regs)
> > {
> > 	return IRQ_NONE;
> > }

> You didn't deal with the source of the interrupt.  Since it's
apparently=20
> level-triggered, the interrupt just comes right back.

> ...  You need to either provide a=20
> real IRQ handler for the Dreamchip, or tell the Dreamchip itself to
mask=20
> the IRQ.

On Dreamchip board itself I couldn't find how to mask the interrupt, but
I'll search more. Can you recommend example for "real" IRQ handler for
Dreamchip? I just don't what the system crash. BTW, what will happen if
Dreamchip and Silicon Image will assert interrupt simultaneously?

Thanks,

Leonid.
