Date: Sun, 17 Mar 02 10:16:02 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0203171816.AA01595@ivan.Harhan.ORG>
To: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] My GT-64260 enhancements
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek <dan@embeddededge.com> wrote:

> I didn't know there was a "default" baud rate for Linux.  I think the lowest
> I have ever seen is 9600, but I certainly wouldn't call it a default.  It
> seems every one of the boards I have uses something different,
>
> The debug console serial port rates are either provided by passing some
> bootloader information to the kernel or by a kernel command line option.
> Either one is locally configurable.

But if you don't specify the baud rate in any way, it'll default to 9600 except
on the EV-64260-BP.

Also I don't like calling the standard serial console "debug". A standard
computer running UNIX or a UNIX-like system must have a standard serial port as
the console for root to do sysadmin work, not a PeeCee video/keyboard. Just
like every standard VAX.

> It shouldn't be a hard-coded value.  It should at least be the standard Linux
> command line option.

That option works of course. I'm simply asking to remove the line from
arch/ppc/config.in that makes the EV-64260-BP port have a different default
from the rest of Linux, which I claim is inappropriate.

> Bootloaders should simply use the port as it was
> configured by the boot rom.

I'm not talking about any bootloader, I'm talking about the kernel (vmlinux).
My bootloader (ppc-linux-boot) doesn't know anything about UARTs at all, it
makes console user services calls to the firmware ROM to talk to the abstract
console device.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
