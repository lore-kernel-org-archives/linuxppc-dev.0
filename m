Date: Tue, 18 Sep 2001 10:38:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Board names for 4xx
Message-ID: <20010918103833.C1183@zax>
References: <20010914144403.G3851@zax> <20010914072847.R21906@cpe-24-221-152-185.az.sprintbbd.net> <20010917122828.J3851@zax> <20010916211605.D14279@cpe-24-221-152-185.az.sprintbbd.net> <3BA61D1A.3A79E5B9@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BA61D1A.3A79E5B9@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Sep 17, 2001 at 11:56:10AM -0400, Dan Malek wrote:
>
> Tom Rini wrote:
>
> > I do wish someone else would speak up tho.  Does anyone out there have an
> > opinion?
>
> It depends how you want to use this information.  In the kernel, it is very
> critical we clearly distinguish between the "core" (the thing that executes
> instructions), the peripherals (the real difference among the SOC-type
> processors), and the board design (which will determine how the peripherals
> are configured).
>
> If the information from /proc is just used for pretty print out of
> information, I really don't care.  If there are applications that read
> this for some internal configuration and flexibility, we better have a
> standard format.

I don't see that we need to structure the information in the machine:
field for this purpose though - if the core and peripherals
information turns out to be important it belongs better in other
fields of /proc/cpuinfo, I think.  We already have cpu: and we could
make a core: if it was necessary - or encode the core information into
cpu: it belongs there more than in machine: I think.  Just the board
type (and revision, where we can find that information) seems the
closest match to what machine: gives on more normal PPC machines.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
