From: "Jeffrey D. Kowing" <jeffrey.d.kowing1@jsc.nasa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15456.23060.255087.831957@igor.jsc.nasa.gov>
Date: Tue, 5 Feb 2002 16:17:56 -0600
To: Hollis Blanchard <hollis@austin.ibm.com>
Cc: jeffrey.d.kowing1@jsc.nasa.gov, linuxppc-dev@lists.linuxppc.org
Subject: Re: io.h and I/O port access from user space
In-Reply-To: <1012945690.1265.11.camel@granite>
References: <15456.16854.183292.343027@igor.jsc.nasa.gov>
	<1012945690.1265.11.camel@granite>
Reply-To: jeffrey.d.kowing1@jsc.nasa.gov
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hollis Blanchard writes:
 > I guess the obvious question is do you have ISA slots in the system
 > you're trying to build for? And you don't want to use the in-kernel
 > stuff? Do you really *need* isapnptools? :)

Well, since you ask and at the risk of further demonstrating my
ignorance:

Yes, I have ISA slots - well, actually, I have a PC/104 stack.

Specifically, I've got an inhouse 603ev/MPC106 board on a PC/104 form
factor running a linuxppc 2.4.x kernel.  I've been using an Adastra
NSP-104 PC/104 module as my network interface card.  That card,
besides its ethernet chip, also has a Super I/O PC87338 chip that
controls two serial ports (i.e. SCC1 and SCC2).  Naturally, I just had
to use those two serial ports, and, of course, it doesn't have nice
little jumpers to set IRQ and IO base addresses.  Instead, it wants to
be configured using Plug-n-Play which I obviously know nothing about.
Anyways, I thought, hey, I'll investigate by using this nifty
isapnptools package.  Silly me.

But beyond my specific problem, I guess it got me to wondering in
general about the proper way to write user space programs using
inb/outb (and in my wildest fantasies of submiting a patch for
isapnptools).

--
Jeff Kowing
jeffrey.d.kowing1@jsc.nasa.gov

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
