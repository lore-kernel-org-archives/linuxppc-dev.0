From: tom_gall@vnet.ibm.com
Message-ID: <3999CF3E.561EB9C8@vnet.ibm.com>
Date: Tue, 15 Aug 2000 23:16:14 +0000
Reply-To: tom_gall@vnet.ibm.com
MIME-Version: 1.0
To: mlan@cpu.lu
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI Buses
References: <200008151939.VAA00754@piglet.grunz.lu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:
>
> Hi Tom,
>
> On  15 Aug, this message from tom_gall@vnet.ibm.com echoed through cyberspace:
> >   Just a stupid question here for those of you that have Mac hardware. Of all
> > the Mac hardware in existance right now, all Macs have at most one PCI bus
> > right?

Hi All,

  I thank you much for the information. It took me a little bit but as I've been
looking at the PCI code I ran across the pmac PCI implementation which
definately has support for more than one PCI bus.

  Where I'm coming from is getting the same thing working on IBM PowerPC
hardware for multiple pythons... fun fun fun...

  Thanks again!


> Wrong :-)
>
> As has been said before, the 9x00 have two PCI busses on two identical
> bandit host bridges.
>
> Also, the 73/75/76/85/8600 have an additional bus called VCI by Apple,
> for accessing video in/out hardware, that behaves exactly like a PCI
> bus.
>
> Then, there are newer Macs, with those based on UniNorth having three
> PCI buses (AGP counted in).

It's definately interesting to hear that AGP is really just another PCI... or at
least treated that way. Being PCI/AGP stupid I appreciate the info... if it's
just another "PCI" of sorts, doesn't that have performance implications or is
that addressed really by the hardware implementation as apposed to the Linux
side of things?

Regards,

--
Tom Gall - PowerPC Linux Team    "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@uswest.net
http://oss.software.ibm.com/developerworks/opensource/linux

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
