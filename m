Date: Sat, 3 Jul 2004 18:42:16 +0200
To: Andy Fleming <afleming@freescale.com>
Cc: Sylvain Munaut <tnt@246tnt.com>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: IRQ Level / Edge
Message-ID: <20040703164216.GA22998@pegasos>
References: <40E5D609.6090201@246tNt.com> <DE336CD5-CC79-11D8-BA44-000393C30512@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <DE336CD5-CC79-11D8-BA44-000393C30512@freescale.com>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jul 02, 2004 at 05:47:59PM -0500, Andy Fleming wrote:
>
> Level sensitive Interrupts will continue to fire until the interrupt is
> cleared.  Essentially, the hardware device causing the interrupt will
> bring the interrupt line up (or down, depending on the polarity), and
> keep it at that level until the condition disappears.  By setting the
> IRQ controller to consider that interrupt level-sensitive, the
> controller knows that the interrupt is still firing, and if you unmask
> the interrupt while the signal is high, it will fire again.
>
> Edge sensitive means that the interrupt only fires on a transition (low
> to high for positive, high to low for negative).  Thus you don't have
> to worry about clearing the interrupt before unmasking it.
>
> I'm not sure if that's clear, but to summarize: Level and edge are
> descriptions of how the interrupt is detected (by the "level" of the
> interrupt, or by a transition *to* that level).  As for where to find
> out which it is, the manual for the device should specify whether the
> interrupt signal is level or edge sensitive.

Err, i suppose the interesting bit is not how the board designer will
know wheter the interrupt is edge or level, but how the kernel running
on the board is able to detect it ?

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
