Date: Wed, 6 Dec 2000 20:07:54 -0500
From: Jonathan Lane <jingai@shell.faradic.net>
Message-Id: <200012070107.eB717sJ23539@shell.faradic.net>
To: bh40@calva.net, jingai@shell.faradic.net
Subject: Re: r128 driver still borked in XF4.0.1-9pre10
Cc: debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >  Bus  0, device  15, function  0:
> >    PCI bridge: DEC DC21052 (rev 1).
> >      Medium devsel.  Fast back-to-back capable.  Master Capable.
> >Latency=32.  Min Gnt=4.
>
> It's indeed a PCI<->PCI bridge. Please look at /proc/device-tree to see
> where the AAPL,interrupt is hidden for bus 1 (should be in the PCI<->PCI
> node).

Appears to be:

/proc/device-tree/bandit/pci-bridge/AAPL,interrupts

Thanks for the help
-j

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
