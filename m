Date: Thu, 24 Feb 2000 09:30:38 -0500
From: Daniel Jacobowitz <drow@false.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: PowerMac G4 and pcmcia flash cards
Message-ID: <20000224093038.A13400@drow.res.cmu.edu>
References: <38B47631.6FE88852@erols.com> <200002242101.QAA01570@marcus.pants.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200002242101.QAA01570@marcus.pants.nu>; from flar@pants.nu on Thu, Feb 24, 2000 at 01:01:59PM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Feb 24, 2000 at 01:01:59PM -0800, Brad Boyer wrote:
>
> Nelson Abramson wrote:
> > >         Do you know what the feasability is of Linux support of Apple's
> > > Airport bases and Airport cards?
> >
> > I imagine fairly possible...I would guess that with the release of mosX and the
> > bsd device drivers for the airport, porting them to *nix would be pretty easy
> > (hopefully)....
>
> Well, since Lucent released Linux drivers for the WaveLan cards, I suspect it
> is much simpler than waiting for Apple to write drivers for Darwin.  Apple
> made an OEM deal with Lucent, so Airport cards have all the same guts as the
> original Lucent cards.  In fact, if you rip apart an Airport base station, you
> will find a genuine Lucent card in a PCMCIA slot.  There was a web site with
> pictures of all the parts from a base station.
>
> 	Brad Boyer
> 	flar@pants.nu
>
> P.S.: The wavelan drivers can be found at http://www.wavelan.com/support/software/
> but they claim that they only work with x86 laptops.  The source is there, so it
> should be possible to fix for ppc.

No, actually.   There are two wavelan drivers; the one there relies on
a non-free (read: binary only) library.  There's a similar one, which I
believe Lucent funded in part, available from the contrib/ directory on
the PCMCIA ftp site - wvlan_cs as opposed to wavelan2_cs.

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
