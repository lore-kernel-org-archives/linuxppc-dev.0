From: Brad Boyer <flar@pants.nu>
Message-Id: <200002242101.QAA01570@marcus.pants.nu>
Subject: Re: PowerMac G4 and pcmcia flash cards
To: pogtal@erols.com (Nelson Abramson)
Date: Thu, 24 Feb 2000 13:01:59 -0800 (PST)
Cc: dan_bethe@yahoo.com (Dan Bethe), linuxppc-dev@lists.linuxppc.org
In-Reply-To: <38B47631.6FE88852@erols.com> from "Nelson Abramson" at Feb 23, 2000 07:07:13 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Nelson Abramson wrote:
> >         Do you know what the feasability is of Linux support of Apple's
> > Airport bases and Airport cards?
>
> I imagine fairly possible...I would guess that with the release of mosX and the
> bsd device drivers for the airport, porting them to *nix would be pretty easy
> (hopefully)....

Well, since Lucent released Linux drivers for the WaveLan cards, I suspect it
is much simpler than waiting for Apple to write drivers for Darwin.  Apple
made an OEM deal with Lucent, so Airport cards have all the same guts as the
original Lucent cards.  In fact, if you rip apart an Airport base station, you
will find a genuine Lucent card in a PCMCIA slot.  There was a web site with
pictures of all the parts from a base station.

	Brad Boyer
	flar@pants.nu

P.S.: The wavelan drivers can be found at http://www.wavelan.com/support/software/
but they claim that they only work with x86 laptops.  The source is there, so it
should be possible to fix for ppc.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
