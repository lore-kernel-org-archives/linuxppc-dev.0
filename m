Subject: Re: check MMU state
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: tglx@linutronix.de
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <200304051735.25831.tglx@linutronix.de>
References: <200304051735.25831.tglx@linutronix.de>
Content-Type: text/plain
Message-Id: <1049554177.654.3.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 05 Apr 2003 16:49:37 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2003-04-05 at 17:35, Thomas Gleixner wrote:
> Hi !
>
> Is there a clean way to check, if the MMU is enabled on kernel entry ? I have
> to port Linux to a PMC-module, where the bootloader code should not be
> changed.

The kernel entry can cope with both cases, provided that early_init
properly returns the physical address where the kernel is loaded,
regardless of the translations setup by the bootloader. Also, the
kernel has to be contiguous in physical memory.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
