Message-ID: <3B49F097.DABAF972@mvista.com>
Date: Mon, 09 Jul 2001 13:57:43 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: James F Dougherty <jfd@GigabitNetworks.COM>
Cc: linuxppc-embedded@lists.linuxppc.org, cort@cs.nmt.edu
Subject: Re: ppc-linux EPIC (OpenPIC) and Interrupts on MPC8240
References: <200107062139.OAA14875@krakatoa.gigabitnetworks.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


James F Dougherty wrote:

> The board is essentially a Motorola Sandpoint design variant, so
> I have started with the MontaVista Sandpoint port of linux-2.3.1

What is linux-2.3.1?  Which version of the Sandpoint?

If it is the old Sandpoint X2, and you are using the EPIC with
discrete interrups (IRQ0 - IRQ4) the latest MontaVista HHL 2.0
should be used (it should be used in any case).  The code in
the public BK trees should also match this release.  If you are
using a Sandpoint X3 with the serial mode interrupt EPIC, there
are some patches I'll have to send you.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
