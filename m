Date: Mon, 8 Apr 2002 09:24:12 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: Michael Sokolov <msokolov@ivan.Harhan.ORG>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_GENERIC_PPC32
Message-ID: <20020408162412.GJ2716@opus.bloom.county>
References: <20020408154808.GH2716@opus.bloom.county> <Pine.LNX.4.33.0204081755150.20339-100000@gra-lx1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.33.0204081755150.20339-100000@gra-lx1.iram.es>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Apr 08, 2002 at 06:03:28PM +0200, Gabriel Paubert wrote:
>
>
> On Mon, 8 Apr 2002, Tom Rini wrote:
>
> > ... And then the pplus stuff ripped out of the 'PReP' support and
> > CONFIG_PPLUS converted too.  Before we get too far along, I should say I
> > actually do like this idea.
>
> Actually, why does CONFIG_PPLUS even exist?

It's my understanding that since they're PReP + bits, it's cleaner to
support them seperatly than in the big prep mess.  It's also easier to
get all of the HW bits working.  But maybe Matt Porter will speak up. :)

> > It's worth noting why these are done as they are, since I'm not sure you
> > quite see why.  pmac and chrp fall into the same category as ppcstar,
> > which is 'We know the firmware, it can be useful, and we will use it'.
> > prep is more along the lines of 'Nothing useful here, but we've been
> > loaded, go go go!'.  The 'simple' stuff is 95% prep, but with the legacy
> > prep workarounds removed.  Also, pmac at least spits out 3 or 4 images
> > as it is.
>
> Actually, PreP residual data can be useful, if you kow how to interpret it
> to find interrupt routing for example.

Well, after talking with Hollis, IBM Residual data _has to be_ good,
since AIX or so relies on it.  But from talking to Cort a few times, he
never could trust it on either IBM or Motorola boxes.

> (Who should have properly submitted his PrePboot code 3 years ago)

Yes.  Willing to dig it up again and try and get it going for 2.5? :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
