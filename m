Date: Tue, 27 Nov 2001 08:41:42 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Matt Porter <mporter@mvista.com>
Cc: Simon Winwood <sjw@cse.unsw.edu.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: More walnut boottime "fun"
Message-ID: <20011127084142.J13091@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011127103042.A11612@cse.unsw.edu.au> <20011126221728.D13091@cpe-24-221-152-185.az.sprintbbd.net> <20011127050754.B15728@cx258813-a.chnd1.az.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011127050754.B15728@cx258813-a.chnd1.az.home.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Nov 27, 2001 at 05:07:54AM -0700, Matt Porter wrote:
>
> On Mon, Nov 26, 2001 at 10:17:28PM -0700, Tom Rini wrote:
> >
> > On Tue, Nov 27, 2001 at 10:30:42AM +1100, Simon Winwood wrote:
> >
> > > 	Apart from NFS not working, it looks like the bootloader is
> > > clobbering itself when the image is reasonably large (> 1M?).
> >
> > There's certain dead-zones now.  Check out
>
> Deadzone. Singular.
>
> > arch/ppc/boot/common/relocate.S for the constraints.  Tomorrow I plan on
> > implementing a slightly smarter relocate that moves the text, jumps
> > there and then relocates data, which should bring us back to the same
> > size deadzones that the original code had.
>
> I don't think you understand what happened.

After sleeping on it I was confusing myself with a different problem...

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
