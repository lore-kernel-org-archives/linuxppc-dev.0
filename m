Date: Tue, 28 Nov 2000 13:19:13 -0600 (CST)
From: Brian Ford <ford@vss.fsi.com>
To: Dan Malek <dan@mvista.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: EST SBC8260 and Canary CTX-1170
In-Reply-To: <3A2322FB.ECCD2CA2@mvista.com>
Message-ID: <Pine.GSO.4.21.0011281308070.493-100000@eos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 27 Nov 2000, Dan Malek wrote:

> That driver either "supports" any PHY, or none at all, depending upon
> your perspective.  None of the command/status MII interface is in
> place to do anything.  None of those functions are called in the
> driver.  The QS6612 comment is left over from the 860T FEC driver I
> copied to get the framework for the FCC driver.
>
So does this mean that a "complete" implementation would have a
"command/status MII interface" or that a "complete" implementation does
not need one?

> From looking at the drivers, it appears they are a little out of
> date.  I have a newer one (that I was certain I checked in) that will
> interrogate the PHY.  In any case, this driver should work fine on
> any half duplex Ethernet, and you should see transmit packets in any
> case.
>
That seems to be my problem.  It is negotiating a full duplex link.

> > I know that the hardware can work, because the VxWorks boot rom loads
> > Linux successfully via this interface and MII.
>
> Then the driver must not be configuring the I/O lines correctly for
> some unknown reason, or you are running full duplex without the FCC
> initialized to do that.
>
Can you help point me to where I need to write code that would initialize
the FCC to do full duplex, or to have it auto-negotiate to half
duplex?  It is fairly problematic for me to force the other end to half
duplex and, ultimately, I would really like to run full.

Thank you for any information that would allow me to write such code.

--
Brian Ford
Software Engineer
Vital Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
