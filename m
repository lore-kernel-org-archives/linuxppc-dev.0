Message-ID: <3999DE0C.4EF5762F@the-rileys.net>
Date: Tue, 15 Aug 2000 20:19:25 -0400
From: David Riley <oscar@the-rileys.net>
MIME-Version: 1.0
To: tom_gall@vnet.ibm.com
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI Buses
References: <200008151939.VAA00754@piglet.grunz.lu> <3999CF3E.561EB9C8@vnet.ibm.com>
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


tom_gall@vnet.ibm.com wrote:

> It's definately interesting to hear that AGP is really just another PCI... or at
> least treated that way. Being PCI/AGP stupid I appreciate the info... if it's
> just another "PCI" of sorts, doesn't that have performance implications or is
> that addressed really by the hardware implementation as apposed to the Linux
> side of things?

It really is just another PCI (there is a 66 MHz PCI specification, and AGP uses
it), though there are improvements made (for example, sidebanding, which gives us
the 2x and 4x modes).  Additionally, it's adapted on the Intel side of things for
"write combining" (if anyone comes up with an exact definition of how that works,
please let me know).  I'm not sure what you mean by performance implications, but
PCI isn't a horrible bus to start with...


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
