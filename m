Message-ID: <3B75C40B.8BCDDD2B@mvista.com>
Date: Sat, 11 Aug 2001 19:47:23 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: James F Dougherty <jfd@GigabitNetworks.COM>
Cc: linuxppc-embedded@lists.linuxppc.org, cort@cs.nmt.edu,
	jfd@cs.stanford.edu
Subject: Re: MPC8240 EPIC Driver (Attached)
References: <200108110718.AAA01730@krakatoa.gigabitnetworks.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


James F Dougherty wrote:
>
> A while ago, I posted some questions on getting the OpenPIC driver working
> correctly for the EPIC (Embedded Programmable Interrupt Controller) internal
> to the MPC8240. After several attempts on open_pic.*, I gave up, and ported a
> an existing driver.

Ummm, I'm confused.  The existing PowerPC OpenPIC works just fine with
the 8240/8245/MPC107 EPICs, at least on the Sandpoint.  I can't believe
there would be much of anything needed for a custom board.  I have some
Sandpoint X3 patches that enables the serial mode control lines as well.
I think there could be a few minor improvements, but it is certainly
functional.  All you should need are the interrupt senses table for
the OpenPIC initialization and the proper routing table for the PCI
setup.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
