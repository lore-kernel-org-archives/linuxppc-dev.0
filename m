Date: Sat, 05 Apr 2003 18:15:40 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: check MMU state
In-reply-to: <1049554177.654.3.camel@zion.wanadoo.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Reply-To: tglx@linutronix.de
Message-id: <200304051815.40797.tglx@linutronix.de>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-15
References: <200304051735.25831.tglx@linutronix.de>
 <1049554177.654.3.camel@zion.wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Saturday 05 April 2003 16:49, Benjamin Herrenschmidt wrote:
> > Is there a clean way to check, if the MMU is enabled on kernel entry ? I
> > have to port Linux to a PMC-module, where the bootloader code should not
> > be changed.
>
> The kernel entry can cope with both cases, provided that early_init
> properly returns the physical address where the kernel is loaded,
> regardless of the translations setup by the bootloader. Also, the
> kernel has to be contiguous in physical memory.
I don't reach early_init. The CPU is a 860 and I'm using 2.4.20-ben8. I get
lost in initial_mmu. If I turn off the mmu before "bl initial_mmu" everything
is fine.

--
Thomas
________________________________________________________________________
linutronix - competence in embedded & realtime linux
http://www.linutronix.de
mail: tglx@linutronix.de


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
