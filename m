Date: Fri, 27 Aug 2004 16:04:07 +0200 (MEST)
From: "Patrick Huesmann" <tricknology@gmx.de>
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
References: <17232.1093615319@www63.gmx.net>
Subject: Re: Kernel oops when initializing ethernet driver
Message-ID: <21930.1093615447@www63.gmx.net>
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

> > I don't even know if we have the VHDL source - the peripherals are
> > ready-to-go logic units that are just inserted in the FPGA design.
> >
> Do you use EDK to build your design?

Yes.

> Is the physical address in your log the one you expect?

Yes.

Apparently, the hardware guy disabled the ethernet controller's "S/W reset"
option in the EDK. This explains why the PPC got no ACK from OPB when
writing to the reset register, and threw the data check exception. I hope
that this problem is solved, when we enable that option.

Thanks again to all who replied,
Patrick


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
