Subject: Re: Linuxppc + MPC860T + Ethernet
To: zimmer_n@gmx.de
Date: Thu, 18 May 2000 10:51:54 +1000 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3922914E.9EC23A6@gmx.de> from "Norbert Zimmermann" at May 17, 2000 02:32:14 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000518005154.AEDE93C976@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Norbert,

Norbert Zimmermann writes:
> has anybody experienced using the Motorola MPC860T with Linuxppc and
> 10BeseT / 100BaseTX in terms of drivers, accessing drivers, etc?

Yes, many of us I suspect. Ethernet driver access is via standard Berkeley
sockets. You can probably tap in lower if you really want, but you probably
compromise the portability advantage of using Linux in the first place.

> My key questions are (@ the mom):
> - How difficult is it to get the Ethernet side of the MPC860T to work.

Very easy, especially if you use an off-the-shelf board which is already
fully supported. For a complete list, see the HOWTO mentioned below.

> - Where can I get Linuxppc Ethernet-Drivers for that purpose from?

In the MontaVista kernel.

> - Where can I get fully documented protocoll stacks, like UDP or TCPIP,
> from?

It's the same protocol stack as any other Linux distribution, so any doco
you find on Linux's internals will apply. You probably don't need to delve
that deeply though; just socket(), bind(), listen(), accept(), read()/write()
from user space and you're away.

> - How do I drive the external bus of the MPC860T using Linuxpppc?

Sounds like you'll either need to write a device driver to interface to the
rest of your system, or (if you're a hero like Dan) dive at it direct from
user space. Depends how complex your device is, and how well you want to
encapsulate/partition it.

For answers to these any many other questions you haven't thought of yet, see
the Linux for PowerPC Embedded Systems HOWTO at:
    http://members.xoom.com/greyhams/linux/PowerPC-Embedded-HOWTO.html

(Dan, have you got write access back to www.ppc.kernel.org yet?)

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
