Message-ID: <3BE2C3CB.DB73EF49@aps.anl.gov>
Date: Fri, 02 Nov 2001 10:03:23 -0600
From: Andrew Johnson <anj@aps.anl.gov>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: EPIC Vs OpenPIC Vs MontaVista
References: <20011102134754.29665.qmail@mailweb16.rediffmail.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sarnath Kannan wrote:
>
>   The reason for assigning vector of 16 to PCI
> interrupts is because each entry in the "Interrupt Source" is 32 bytes long, 16 * 32 = 512 = 0x200
> which equals the difference in offsets between
> the std openPIC layout and EPIC register layout.
> This 16 has got NOTHING TO DO with NUM_8259_INTERRUPTS.
> But Mvista code seems to assume that this feature
> is because of NUM_8259_INTERRUPTS. ( See the
> #define for SANDPOINT_SIO_IRQ ).

... unless the register layout for the EPIC was designed to allow an
external i8259 to be inserted into the gap, which ISTR is done on some
boards.  I don't know for sure and I might be completely confused about
that, but there must have been some reason why the EPIC was designed like
that.

Just throwing that idea into the pot...

- Andrew
--
Perfection is reached, not when there is no longer anything to add,
but when there is no longer anything to take away.
- Antoine de Saint-Exupery

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
