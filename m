From: Josh Huber <huberj@WPI.EDU>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14330.56381.536665.10630@cpu.wpi.edu>
Date: Wed, 6 Oct 1999 01:21:01 -0400 (EDT)
To: linuxppc-dev@lists.linuxppc.org
Subject: pcmcia-cs issues with flash?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Has anyone had any luck with flash cards (compact flash in particular) with pcmcia adaptors on ppc? I've got a Wallstreet PBG3/233.

I grabbed a precompiled rpm (and converted it to .deb with alien), installed it, and started it up.

I get:
Oct  5 21:01:09 majere kernel: Linux PCMCIA Card Services 3.0.12
Oct  5 21:01:09 majere kernel:   kernel build: 2.2.12 #4 Sat Sep 11 02:48:37 CEST 1999
Oct  5 21:01:09 majere kernel:   options:  [pci] [cardbus]
Oct  5 21:01:09 majere kernel: Intel PCIC probe: 
Oct  5 21:01:09 majere kernel:   TI 1131 PCI-to-CardBus at bus 0 slot 19, mem 0x81803000, 2 sockets
Oct  5 21:01:09 majere kernel:     host opts [0]: [isa irq] [pci irq 22] [lat 32/176] [bus 1/4]
Oct  5 21:01:09 majere kernel:     host opts [1]: [isa irq] [pci irq 23] [lat 32/176] [bus 6/9]
Oct  5 21:01:09 majere kernel:     PCI card interrupts, polling interval = 1000 ms
Oct  5 21:01:09 majere kernel: cs: memory probe 0x90000000-0x90ffffff: clean.

And then, when I try and insert a compact flash card, this:
Oct  5 21:01:15 majere kernel: ide_cs: ide_register() at 0x  0 & 0x  e, irq 23 failed

I tried without luck compiling the newest version of pcmcia-cs (3.1.1something I believe), which managed to drop me into xmon 100% of the time. (i didn't know xmon worked on the local machine -- thought it was only serial! :)

Anyone?

Josh

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
