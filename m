From: "Ron Bianco" <ronb@junction.net>
To: "bhupinder sahran" <bhup_sah@yahoo.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 21554 device driver
Date: Fri, 3 Aug 2001 17:00:42 -0700
Message-ID: <000301c11c78$80e43fe0$4d012ac7@warp-speed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20010803233752.6137.qmail@web3807.mail.yahoo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Sorry, I can't point you to info on setting up such a beast.
However, the 8240 is able to handle up to 5 pci devices on it's own and has an internal arbiter.
66Mhz PCI too in some configurations.
Therefore I'm curious about the fact that you apparently want to interface to more than 5 PCI devices.
Is this correct?  Seems extreme for an embedded system.

Cheers, Ron

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of
> bhupinder sahran
> Sent: Friday, August 03, 2001 4:38 PM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: 21554 device driver
>
>
>
> hello friends
> i am Bhupender Saharan.
> i have ported linux on MPC8240 board.
> on the PCI bus of MPC8240 i am having a 21554(non
> transparent) pci bridge.
> i need a driver for this bridge.
> if u guys can send a refernce code or link, that will
> be nice for me.
> thanx in advance.
>
> with regards
> Bhupi
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
