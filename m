Date: Fri, 25 Jan 2002 10:28:12 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: <hollis@austin.ibm.com>
Cc: Michel Lanners <mlan@cpu.lu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: RFC: vesafb
In-Reply-To: <20020124221736.GZ510@austin.ibm.com>
Message-ID: <Pine.LNX.4.33.0201251022430.9804-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 24 Jan 2002 hollis@austin.ibm.com wrote:

>
> On Thu, Jan 24, 2002 at 05:42:46AM +0100, Michel Lanners wrote:
> > On  23 Jan, this message from hollis@austin.ibm.com echoed through cyberspace:
> > > The attached patch allows vesafb to work on PPC. vesafb does surprisingly
> > > little with the BIOS (which I thought was the whole point of VESA). With
> > > some ifdef's I'm able to use it as sort of a VGA offb -- the firmware
> > > initializes the card, and the driver just uses it and never mucks with it.
> >
> > Wouldn't this be a good start to use generic PC-type grafic cards on PPC
> > machines in general? Or do you lack initialization if nobody (neither
> > firmware nor OS) can talk to the card 'natively'?
>
> Yes, we would lack initialization on Power Mac (for example). PReP firmware
> does proper setup for a very limited range of chips, which is why this is
> useful at all.

I remind you that I am using since 3 years or so an x86 emulator which
should allow to initialize any board with has an x86 ROM BIOS, provided
the host bridge can be configured to generate VGA memory accesses
(0xa0000-0xbffff), so I think most MACs are out. It is in my bootloader
but I have no time to work on it right now, some people have expressed
interest in including it in the official source tree but I don't believe
it will happen soon.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
