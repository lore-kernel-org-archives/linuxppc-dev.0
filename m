Subject: Re: Embedded planet CLLF boards
To: daniel.furse@iptest.com (Daniel Furse)
Date: Fri, 6 Oct 2000 12:23:33 +1100 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
In-Reply-To: <0D9416AE7F95D411A8710008C7332F3F0E38@GUILDFORD4_NT> from "Daniel Furse" at Oct 05, 2000 03:46:24 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20001006012333.4707C23A@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Daniel Furse writes:
> Can anyone recommend an 860T-based board, which has both a fast ethernet
> and a PCMCIA interface?
...
> We were hoping to find a complete evaluation board, which we could
> replicate royalty-free (which is why we selected the FADS card initially),
> but that seems to be impossible.

There are only so many degrees of freedom available in an 860T-based board
using the FEC and PCMCIA interfaces, because so much is already on-chip.

You need to be careful not to infringe on EP or TQC's intellectual property,
and you can't just replicate their designs.  However, if you design your
hardware to match the components supported by the kernel, you end up needing
only minor software changes between their boards and yours, without
replicating the hardware design.  In other words, if you must do a custom
board, design it to be compatible with the kernel, rather than to mimic other
people's boards.

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
