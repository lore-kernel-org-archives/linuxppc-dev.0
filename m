Message-ID: <3A10012D.DFA76093@agelectronics.co.uk>
Date: Mon, 13 Nov 2000 14:56:45 +0000
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: Pei-Jie Hong <Pei-Jie.Hong@cern.ch>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCI-to-PCI bridge 21554?
References: <3A0FF521.D2358D7D@cern.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pei-Jie Hong wrote:
>         We are recently working on the PCI-to-PCI bridge 21554, which
> is a non-transparent bridge. But we have some problem with it. Does
> anyone on this list ever do something with this bridge. Thanks.

I've been working with this bridge for a few months now, using it with
an x86 PC on the primary side and a PowerPC SBC on the other. I've so
far set up address translations across it, and used the I2O unit without
any problems. What are you trying to do with the 21554, and what sort of
board is it on?

- Adrian Cox, AG Electronics

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
