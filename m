From: Joe Green <jgreen@mvista.com>
To: Pei-Jie Hong <Pei-Jie.Hong@cern.ch>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCI-to-PCI bridge 21554?
Date: Mon, 13 Nov 2000 09:45:49 -0800
Content-Type: text/plain
References: <3A0FF521.D2358D7D@cern.ch>
In-Reply-To: <3A0FF521.D2358D7D@cern.ch>
MIME-Version: 1.0
Message-Id: <00111309465001.09296@minotaur.mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 13 Nov 2000, Pei-Jie Hong wrote:
> 	We are recently working on the PCI-to-PCI bridge 21554, which
> is a non-transparent bridge. But we have some problem with it. Does
> anyone on this list ever do something with this bridge. Thanks.

The Hard Hat Net drivers in the MontaVista kernel use the 21554 to
emulate an Ethernet connection between multiple CompactPCI boards.

--
Joe Green <jgreen@mvista.com>
MontaVista Software, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
