Message-ID: <39A27606.B38463BF@agelectronics.co.uk>
Date: Tue, 22 Aug 2000 13:45:58 +0100
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: Michael Lundkvist <ml@epact.se>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IP over a PCI-bus
References: <qpk8d9plq4.fsf@erbium.epact.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Michael Lundkvist wrote:
> The PMC doesn't have it's own ethernet interface and I would like to
> be able to communicate with the carrier board over the PCI bus using
> IP.
>
> Has anyone done any work on a network driver for a system like that?

Yes. My code requires an I2O unit on the add-in board, and I'm not sure
if your 860 board has one. Contact me if you want more details, as I
don't currently have an easy patch to install this.

- Adrian Cox, AG Electronics

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
