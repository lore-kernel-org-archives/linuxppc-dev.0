Message-Id: <200012081959.TAA30962@hyperion.valhalla.net>
Date: Fri, 08 Dec 2000 19:34:47 +0000
Subject: Re: AW: Sound on an iBook?
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: "D.J. Barrow" <barrow_dj@yahoo.com>,
        "linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
CC: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        "Halfmann, Klaus" <khalfmann@libra.de>,
        linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


D.J. Barrow wrote:

> No I2C is as old as the hills, I2C is a philips serial
> bus standard for talking to upto 256 devices on the
> one two wire bus. It is pretty crappy simple & slow &
> philips generally used it to talk to digital tuners on
> radios.

well, there are other versions faster and with bigger address ranges... but
that wasn't my point.

we are all quite familiar with i2c.

the new thing here is the particular Apple hardware, registers etc. used to
implement the bus interface... another set of stuff we may have to deduce
the hard way.

it's not the cuda - the iBook doesn't have a cuda - AFAIK.  (PMU, I expect).

and... actually, I think the asics are more there to keep costs down... but
each to his own ;-)


Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
