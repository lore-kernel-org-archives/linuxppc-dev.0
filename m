From: hollis@austin.ibm.com
Date: Thu, 24 Jan 2002 16:17:36 -0600
To: Michel Lanners <mlan@cpu.lu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: RFC: vesafb
Message-ID: <20020124221736.GZ510@austin.ibm.com>
References: <20020123192010.GP510@austin.ibm.com> <E16Tbiw-00008o-00@piglet.grunz.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E16Tbiw-00008o-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 24, 2002 at 05:42:46AM +0100, Michel Lanners wrote:
> On  23 Jan, this message from hollis@austin.ibm.com echoed through cyberspace:
> > The attached patch allows vesafb to work on PPC. vesafb does surprisingly
> > little with the BIOS (which I thought was the whole point of VESA). With
> > some ifdef's I'm able to use it as sort of a VGA offb -- the firmware
> > initializes the card, and the driver just uses it and never mucks with it.
>
> Wouldn't this be a good start to use generic PC-type grafic cards on PPC
> machines in general? Or do you lack initialization if nobody (neither
> firmware nor OS) can talk to the card 'natively'?

Yes, we would lack initialization on Power Mac (for example). PReP firmware
does proper setup for a very limited range of chips, which is why this is
useful at all.

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
