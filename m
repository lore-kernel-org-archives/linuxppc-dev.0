From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15366.8953.429603.173303@gargle.gargle.HOWL>
Date: Thu, 29 Nov 2001 22:58:49 +1100 (EST)
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ide_init_hwif_ports
In-Reply-To: <3C05F807.9090806@humboldt.co.uk>
References: <15365.51839.327359.844495@gargle.gargle.HOWL>
	<3C05F807.9090806@humboldt.co.uk>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Adrian Cox writes:

> The one important thing that the ide_init_hwif function handles for one
> of my boards (and for the sandpoint) is the knowledge that the irqs are
> 14 and 15. If left to its own devices the pci-ide code  will assume that
> both channels are on the same irq, which leaves the second channel
> running without interrupts.

Ah, OK.  Is this the 82c105?  Are the two channels separate PCI
functions in the device, or are they the same function?

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
