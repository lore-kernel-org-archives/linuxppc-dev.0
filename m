Subject: Re: io.h and I/O port access from user space
From: Hollis Blanchard <hollis@austin.ibm.com>
To: jeffrey.d.kowing1@jsc.nasa.gov
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <15456.23060.255087.831957@igor.jsc.nasa.gov>
References: <15456.16854.183292.343027@igor.jsc.nasa.gov>
	<1012945690.1265.11.camel@granite>
	<15456.23060.255087.831957@igor.jsc.nasa.gov>
Content-Type: text/plain
Date: 05 Feb 2002 17:07:46 -0600
Message-Id: <1012950466.1350.17.camel@granite>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2002-02-05 at 16:17, Jeffrey D. Kowing wrote:
>
> Specifically, I've got an inhouse 603ev/MPC106 board on a PC/104 form
> factor running a linuxppc 2.4.x kernel.  I've been using an Adastra
> NSP-104 PC/104 module as my network interface card.  That card,
> besides its ethernet chip, also has a Super I/O PC87338 chip that
> controls two serial ports (i.e. SCC1 and SCC2).  Naturally, I just had
> to use those two serial ports, and, of course, it doesn't have nice
> little jumpers to set IRQ and IO base addresses.  Instead, it wants to
> be configured using Plug-n-Play which I obviously know nothing about.
> Anyways, I thought, hey, I'll investigate by using this nifty
> isapnptools package.  Silly me.

Have you tried enabling CONFIG_PNP and CONFIG_ISAPNP? That's all I had
to do to get ISA PnP working for an onboard sound card here.

-Hollis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
