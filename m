Date: Mon, 8 Apr 2002 18:03:28 +0200 (CEST)
From: Gabriel Paubert <paubert@iram.es>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Michael Sokolov <msokolov@ivan.Harhan.ORG>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_GENERIC_PPC32
In-Reply-To: <20020408154808.GH2716@opus.bloom.county>
Message-ID: <Pine.LNX.4.33.0204081755150.20339-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 8 Apr 2002, Tom Rini wrote:

> ... And then the pplus stuff ripped out of the 'PReP' support and
> CONFIG_PPLUS converted too.  Before we get too far along, I should say I
> actually do like this idea.

Actually, why does CONFIG_PPLUS even exist? They are basically PreP with
an OpenPIC and slightly different (in some cases) MMIO and I/O mapping,

(Side note: on my MVME2xxx boards which are set in PreP mode by the
firmware, I reinitialize the bridge to be CHRP like, just because I need
larger MMIO area for VME but 1Gb of I/O space is overkill).

> It's worth noting why these are done as they are, since I'm not sure you
> quite see why.  pmac and chrp fall into the same category as ppcstar,
> which is 'We know the firmware, it can be useful, and we will use it'.
> prep is more along the lines of 'Nothing useful here, but we've been
> loaded, go go go!'.  The 'simple' stuff is 95% prep, but with the legacy
> prep workarounds removed.  Also, pmac at least spits out 3 or 4 images
> as it is.

Actually, PreP residual data can be useful, if you kow how to interpret it
to find interrupt routing for example.

	Gabriel.
	(Who should have properly submitted his PrePboot code 3 years ago)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
