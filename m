Date: Wed, 23 Oct 2002 14:08:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Todd Poynor <tpoynor@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: very minor 405GP and 405GPr PCI difference
Message-ID: <20021023040850.GC1198@zax>
References: <20021002053422.GL1848@zax> <20021002100312.A2240@home.com> <20021003011044.GB1102@zax> <20021003081439.C4643@home.com> <20021004024832.GG1933@zax> <3D9DDEE9.5070909@mvista.com> <20021008041758.GG32555@zax> <3DA3347B.1000004@mvista.com> <20021009021403.GQ32555@zax> <3DB5C963.8020201@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3DB5C963.8020201@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Oct 22, 2002 at 02:55:47PM -0700, Todd Poynor wrote:
>
> David Gibson wrote (regarding Rainier PMM1 bios_fixup in MVL):
>
> >Well, it may be in a different place, but it looks like it has the
> >same problem.  It is still establishing a PCI window at PLB address
> >0x80000000, which is the same address used for the PMM0 window - or is
> >that also different in the MV kernel?
> >
> >I'd be trying to work out what that mapping's actually for, first.  I
> >still can't see how it can possibly work - if there are overlapping
> >PMM windows, what actually happens to accesses in that (PLB) range?
>
> Yes, it looks like MVL only sets up the one window using PMM1... we've
> started an effort to have the Rainier-knowedgeable folks get the code
> sync'ed up with the community and this should happen soon.

Hang on, so just to clarify - MVL sets up PMM1 with the code you
posted, but doesn't set up PMM0 anywhere?  From my reading of that
code, it sets up a window at the same address as the "standard"
(Walnut) mapping, except that it is only 128kB instead of 1GB.  Is
there a reason that Rainier must have such a small window?

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
